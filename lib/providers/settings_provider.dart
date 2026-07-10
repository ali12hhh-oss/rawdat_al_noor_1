import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';
import '../services/notification_service.dart';

/// يدير إعدادات عامة إضافية للتطبيق (الوضع الليلي + التذكير اليومي)
/// إعدادات الصوت واللغة تُدار عبر AudioProvider و LanguageProvider تحديداً
class SettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  bool _isDarkMode = false;
  bool _isDailyReminderEnabled = false;

  SettingsProvider(this._prefs) {
    _isDarkMode = _prefs.getBool(AppConstants.keyDarkMode) ?? false;
    _isDailyReminderEnabled = _prefs.getBool(AppConstants.keyDailyReminder) ?? false;
  }

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  bool get isDailyReminderEnabled => _isDailyReminderEnabled;

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs.setBool(AppConstants.keyDarkMode, value);
    notifyListeners();
  }

  /// تفعيل/إيقاف تذكير التدرّب اليومي (يطلب إذن الإشعارات عند التفعيل)
  /// يُعيد false إذا رفض المستخدم منح إذن الإشعارات
  Future<bool> toggleDailyReminder(bool value) async {
    if (value) {
      final granted = await NotificationService().requestPermission();
      if (!granted) {
        return false;
      }
      await NotificationService().scheduleDailyReminder();
    } else {
      await NotificationService().cancelAll();
    }
    _isDailyReminderEnabled = value;
    await _prefs.setBool(AppConstants.keyDailyReminder, value);
    notifyListeners();
    return true;
  }
}

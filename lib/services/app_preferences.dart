import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _prefs;

  static AppPreferences? _instance;

  AppPreferences._();

  static Future<AppPreferences> getInstance() async {
    _prefs = await SharedPreferences.getInstance();
    _instance ??= AppPreferences._();
    return _instance!;
  }

  // device preferences
  String? getDeviceId() => _prefs.getString('device_id');

  Future<bool> setDeviceId(String value) =>
      _prefs.setString('device_id', value);

  // tuneinsta guide dialog
  Future<bool>? setShouldShowTuneinstaGuide(bool value) =>
      _prefs.setBool('should_show_tuneinsta_guide', value);

  bool getShouldShowTuneinstaGuide() =>
      _prefs.getBool('should_show_tuneinsta_guide') ?? true;


}

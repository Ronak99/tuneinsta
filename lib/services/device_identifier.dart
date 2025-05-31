import 'package:app/utils/secure_random.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdentifier {
  late SharedPreferences _prefs;
  late String deviceId;

  DeviceIdentifier();

  init() async {
    _prefs = await SharedPreferences.getInstance();

    String? deviceId = _prefs.getString("device_id");

    if(deviceId == null){
      deviceId = getRecordId();
      _prefs.setString("device_id", deviceId);
    }

    this.deviceId = deviceId;
  }
}
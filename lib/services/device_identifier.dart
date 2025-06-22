import 'package:app/services/app_preferences.dart';
import 'package:app/utils/secure_random.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdentifier {
  late String deviceId;

  DeviceIdentifier() {
    String? deviceId = Get.find<AppPreferences>().getDeviceId();

    if(deviceId == null){
      deviceId = getRecordId();
      Get.find<AppPreferences>().setDeviceId(deviceId);
    }

    this.deviceId = deviceId;
  }
}
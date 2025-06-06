import 'package:app/app.dart';
import 'package:app/firebase_options.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/device_identifier.dart';
import 'package:app/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final router = RouteGenerator.generateRoutes();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(Logger());

  // if (kDebugMode) {
  //   Get.find<Logger>().d("Using Firebase Emulator");
  //   try {
  //     final emulatorHost = defaultTargetPlatform == TargetPlatform.android
  //         ? "localhost"
  //         : "localhost";
  //     FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
  //     FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  //     FirebaseFunctions.instance.useFunctionsEmulator(emulatorHost, 5001);
  //   } catch (e) {
  //     Get.find<Logger>().e(e);
  //   }
  // }


  // init
  _initializeServices();
  await Get.find<DeviceIdentifier>().init();

  // init cubits
  RouteGenerator.initializeCubits();

  _initializeSystemUIDefaults();

  runApp(const App());
}


void _initializeSystemUIDefaults() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: SystemUiOverlay.values,
  );
}

void _initializeServices() {
  Get.put(DeviceIdentifier());
  Get.put(StorageService());
  Get.put(DbService());
}

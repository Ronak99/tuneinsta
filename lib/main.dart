import 'package:app/app.dart';
import 'package:app/firebase_options.dart';
import 'package:app/route_generator.dart';
import 'package:app/services/db_service.dart';
import 'package:app/services/storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Logger _logger = Logger();
final router = RouteGenerator.generateRoutes();

void main() async {
  // init cubits
  RouteGenerator.initializeCubits();

  // put logger
  Get.put(_logger);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    Get.find<Logger>().d("Using Firebase Emulator");
    try {
      final emulatorHost = defaultTargetPlatform == TargetPlatform.android
          ? "localhost"
          : "localhost";
      FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
      FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
    } catch (e) {
      Get.find<Logger>().e(e);
    }
  }

  _initializeServices();

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
  Get.put(StorageService());
  Get.put(DbService());
}

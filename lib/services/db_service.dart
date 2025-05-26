import 'package:app/utils/secure_random.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void makeTestFirestoreRecord() async {
    try {
      _firestore.collection('uploads').add({"key": "value"});
    } catch (e) {
      Get.find<Logger>().e("Error occurred with Firestore.");
    }
  }

  Future<String> createTask({
    required String fileName,
    required String uploadPath,
    required String mimeType,
  }) async {
    try {
      String id = getRecordId();
      await _firestore.doc('tasks/$id').set({"id": id});
      return id;
    } catch (e) {
      Get.find<Logger>().e("Error occurred while creating upload record.");
      throw Exception(e);
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> taskStream(String taskId) =>
      _firestore.doc('tasks/$taskId').snapshots();
}

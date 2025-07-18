import 'package:app/models/task/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Task> get taskCollectionReference =>
      _firestore.collection('tasks').withConverter(
          fromFirestore: (data, _) => Task.fromJson(data.data()!),
          toFirestore: (task, options) => task.toJson());

  Future<void> createTask(Task task) async {
    try {
      await taskCollectionReference.doc(task.id).set(task);
    } catch (e) {
      Get.find<Logger>().e("Error occurred while creating upload record.");
      throw Exception(e);
    }
  }

  Future<Task> getTask(String taskId) async {
    try {
      return (await taskCollectionReference.doc(taskId).get()).data()!;
    } catch (e) {
      Get.find<Logger>().e("Error occurred while creating upload record.");
      throw Exception(e);
    }
  }

  Future<void> extractSongs(String taskId) async {
    await FirebaseFunctions.instance.httpsCallable('extractSongs').call({
      "task_id": taskId,
    });
  }

  Future<QuerySnapshot<Task>> getTasks(String deviceId) async {
    return await taskCollectionReference
        .where('created_by', isEqualTo: deviceId)
        .limit(10)
        .get();
  }

  Stream<List<Task>> streamTasks(String deviceId) => taskCollectionReference
      .where('created_by', isEqualTo: deviceId)
      .orderBy('created_on', descending: true)
      .limit(10)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());

  Stream<Task> streamTask(String taskId) => taskCollectionReference
      .doc(taskId)
      .snapshots()
      .where((snapshot) => snapshot.exists)
      .map((snapshot) => snapshot.data()!);
}

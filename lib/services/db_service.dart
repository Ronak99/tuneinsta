import 'package:app/models/song/Song.dart';
import 'package:app/models/task/Task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _password;

  String? get password => _password;

  DbService() {
    _iniializeAdminPassword();
  }

  void _iniializeAdminPassword() async {
    _password =
        (await _firestore.doc('admin_config/password').get()).get("password");
  }

  CollectionReference<Task> get taskCollectionReference =>
      _firestore.collection('tasks').withConverter(
          fromFirestore: (data, _) => Task.fromJson(data.data()!),
          toFirestore: (task, options) => task.toJson());

  CollectionReference<Song> get songCollectionReference =>
      _firestore.collection('songs').withConverter(
          fromFirestore: (data, _) => Song.fromJson(data.data()!),
          toFirestore: (song, options) => song.toJson());

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

  Future<QuerySnapshot<Task>> getTasks(String deviceId) =>
      taskCollectionReference
          .where('created_by', isEqualTo: deviceId)
          .limit(10)
          .get();

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

  Stream<List<Song>> streamSongsDirectory() => songCollectionReference
      .orderBy('added_on', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());

  Future<void> addSong(Song song) async {
    try {
      _firestore.collection('backup_songs').doc(song.id).set(song.toJson(), SetOptions(merge: true),);
      await songCollectionReference.doc(song.id).set(
            song,
            SetOptions(merge: true),
          );
    } catch (e) {
      Get.find<Logger>().e("Error occurred while adding song.");
      throw Exception(e);
    }
  }

  void deleteSong(String songId) =>
      songCollectionReference.doc(songId).delete();
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final RxDouble uploadProgress = 0.0.obs;

  Future<String> uploadPicture({
    required File file,
    required String uploadPath,
    required String mimeType,
    required String taskId,
  }) async {
    try {
      final ref = _storage.ref().child(uploadPath);
      final UploadTask uploadTask = ref.putFile(file);


      // Listen to progress updates
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (snapshot.totalBytes > 0) {
          uploadProgress.value =
              snapshot.bytesTransferred / snapshot.totalBytes;
        }
      });

      // Wait for completion
      final TaskSnapshot completedSnapshot = await uploadTask;

      // always update the metadata after you await the task snapshot.
      ref.updateMetadata(
        SettableMetadata(
          contentType: mimeType,
          customMetadata: {
            "task_id": taskId
          }
        ),
      );
      final downloadUrl = await completedSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // Handle errors as needed
      throw Exception("Error while uploading.");
    }
  }
}

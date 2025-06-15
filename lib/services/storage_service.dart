import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

typedef UploadResponse = ({String bucket, String downloadUrl});

class StorageService extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final RxDouble uploadProgress = 0.0.obs;

  Future<UploadResponse> uploadPicture({
    required File file,
    required String uploadPath,
    required String mimeType,
  }) async {
    try {
      final ref = _storage.ref().child(uploadPath);

      // Reset progress before starting
      uploadProgress.value = 0.0;

      // Create the upload task with metadata upfront
      final metadata = SettableMetadata(contentType: mimeType);
      final UploadTask uploadTask = ref.putFile(file, metadata);

      // Set up progress listener BEFORE starting the upload
      late StreamSubscription progressSubscription;

      progressSubscription = uploadTask.snapshotEvents.listen(
        (TaskSnapshot snapshot) {
          if (snapshot.totalBytes > 0) {
            final progress = snapshot.bytesTransferred / snapshot.totalBytes;
            uploadProgress.value = progress;

            Get.find<Logger>().i(
                "Upload progress: ${(progress * 100).toStringAsFixed(1)}% "
                "(${snapshot.bytesTransferred}/${snapshot.totalBytes} bytes)");
          }
        },
        onError: (error) {
          Get.find<Logger>().e("Upload progress error: $error");
        },
      );

      try {
        // Wait for upload completion
        final TaskSnapshot completedSnapshot = await uploadTask;

        // Clean up the subscription
        await progressSubscription.cancel();

        // Ensure progress shows 100% at completion
        uploadProgress.value = 1.0;

        final downloadUrl = await completedSnapshot.ref.getDownloadURL();

        Get.find<Logger>().i("Upload completed successfully");

        return (bucket: ref.bucket, downloadUrl: downloadUrl);
      } catch (uploadError) {
        // Clean up subscription on error
        await progressSubscription.cancel();
        rethrow;
      }
    } catch (e) {
      Get.find<Logger>().e("Upload error: $e");
      throw Exception("Error while uploading: ${e.toString()}");
    }
  }

  // Optional: Method to cancel ongoing upload
  Future<void> cancelUpload() async {
    uploadProgress.value = 0.0;
  }
}

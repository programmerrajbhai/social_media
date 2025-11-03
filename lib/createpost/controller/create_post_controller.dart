import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../api/create_post_api_service.dart';
import '../models/upload_model.dart';

class CreatePostController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);


  final titleController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }




  void removeImage() {
    selectedImage.value = null;
  }



  Future<void> uploadToServer() async {
    if (titleController.text.isEmpty || selectedImage.value == null) {
      Get.snackbar("Error", "Please add text and image both");
      return;
    }

    String base64Image = base64Encode(await selectedImage.value!.readAsBytes());
    final model = UploadModel(title: titleController.text, imageBase64: base64Image);

    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    final message = await ApiService.uploadData(model);
    Get.back();

    Get.snackbar("Server Response", message);
  }
}

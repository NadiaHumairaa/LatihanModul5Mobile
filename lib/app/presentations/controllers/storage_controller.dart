import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihanmodul5/app/presentations/controllers/client_controller.dart';

class StorageController extends ClientController {
  Storage? storage;
  @override
  void onInit() {
    super.onInit();
    // appwrite
    storage = Storage(client);
  }

  Future storeImage(File file) async {
    try {
      final result = await storage!.createFile(
        bucketId: '6566f871529f52369a55',
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: file.path,
          filename: '20230828_134941 (1).jpg',
        ),
      );
      print("StorageController:: storeImage $result");
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
    }
  }

  Future<List<String>> listImages() async {
    try {
      final result = await storage!.listFiles(
        bucketId: '6566f871529f52369a55',
      );
      List<String> imageUrls = [];
      for (var file in result.files) {
        String imageUrl = storage!.getFileView(
          bucketId: '6566f871529f52369a55',
          fileId: file.$id,
        ) as String;
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (error) {
      Get.defaultDialog(
        title: "Error Storage",
        titlePadding: const EdgeInsets.only(top: 15, bottom: 5),
        titleStyle: Get.context?.theme.textTheme.titleLarge,
        content: Text(
          "$error",
          style: Get.context?.theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
      );
      return [];
    }
  }
}

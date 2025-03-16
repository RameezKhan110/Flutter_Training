
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FileUtils {

  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image != null) {
        var selectedImage = File(image.path);
        print("selected image $selectedImage");
        return selectedImage;
      }
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
    return null;
  }
}
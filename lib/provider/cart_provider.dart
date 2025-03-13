
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_training/dio/rest_api_service.dart';
import 'package:image_picker/image_picker.dart';

import '../dio/dio_service.dart';
import '../utils/get_storage_helper.dart';

class CartProvider extends ChangeNotifier {

  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  RestApiService apiService = RestApiService();
  String fileUrl = "";
  GetStorageHelper getStorageHelper = GetStorageHelper();


  Future pickImage() async {
    try {
      // updateBaseUrl();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      _selectedImage = File(image.path);
      print("selected image $_selectedImage");
      notifyListeners();
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> updateBaseUrl() async {
    var dio = DioService();
    String url = await getStorageHelper.readStorage("platzi_base_url");
    dio.changeBaseUrl(url);
  }

  Future<void> fileUpload(Uint8List bytes, String fileName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.uploadFile(bytes, fileName);
      fileUrl = response?.data['location'];
      print("file uploaded $response");
    } catch (e) {
      // imagesData.error = "$e";
    }
    _isLoading = false;
    notifyListeners();
  }
}
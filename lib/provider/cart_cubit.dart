import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/dio/rest_api_service.dart';
import '../utils/get_storage_helper.dart';

class CartCubit extends Cubit<CartApiState> {

  RestApiService apiService = RestApiService();
  GetStorageHelper getStorageHelper = GetStorageHelper();

  CartCubit(this.apiService) : super(CartApiInitial());

  // Future<void> updateBaseUrl() async {
  //   var dio = DioService();
  //   String url = await getStorageHelper.readStorage("platzi_base_url");
  //   dio.changeBaseUrl(url);
  // }

  Future<void> fileUpload(Uint8List bytes, String fileName) async {
    emit(CartApiLoading());
    try {
      final response = await apiService.uploadFile(bytes, fileName);
      if (response?.data != null) {
        print("file uploaded $response");
        emit(CartApiSuccess("File has been successfully loaded"));
      }
    } catch (e) {
      emit(CartApiError("Failed to upload file"));
    }
  }
}

abstract class CartApiState {}

class CartApiInitial extends CartApiState {}

class CartApiLoading extends CartApiState {}

class CartApiSuccess extends CartApiState {
  final String data;

  CartApiSuccess(this.data);
}

class CartApiError extends CartApiState {
  final String errorMessage;

  CartApiError(this.errorMessage);
}

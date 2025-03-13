import 'package:dio/dio.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';
import 'dart:typed_data';

class DioService {
  late Dio _dio;
  GetStorageHelper getStorageHelper = GetStorageHelper();
  String baseUrl = "";

  DioService() {
    final options = BaseOptions(
      baseUrl: getStorageHelper.readStorage("base_url"),
      contentType: "application/json",
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 30),
    );

    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add Bearer token to every request
          final token = getStorageHelper.readStorage("bearer_token");
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) {
          // Handle errors globally here
          return handler.next(e);
        },
      ),
    );
  }

  void changeBaseUrl(String url) {
    if (url.isNotEmpty) {
      baseUrl = url;
      return;
    }
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParams);
    } on DioException catch (e) {
      // Handle error
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<Response?> uploadImageFromBytes(
    String endpoint,
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(bytes, filename: fileName),
        }),
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } on DioException catch (e) {
      rethrow;
    }
  }
}

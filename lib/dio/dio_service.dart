import 'package:dio/dio.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';

class DioService {

  late Dio _dio;
  GetStorageHelper getStorageHelper = GetStorageHelper();

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

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
       return await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
    } on DioException catch (e) {
      // Handle error
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}

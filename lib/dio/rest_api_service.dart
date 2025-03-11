import 'package:dio/dio.dart';
import 'package:flutter_training/dio/dio_service.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';

class RestApiService {

  final dioService = DioService();
  GetStorageHelper getStorageHelper = GetStorageHelper();

  Future<Response> getPopularMovies(int page) async {
    try {
      final response = await dioService.get(getStorageHelper.readStorage("popular_movies"), queryParams: {"page": page, "language": "en-US",});
      return response;
    } on DioException catch (e) {
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<Response> getTopRatedMovies(int page) async {
    try {
      final response = await dioService.get(
        getStorageHelper.readStorage("top_rated_movies"), queryParams: {"page": page, "language": "en-US"});
      return response;
    } on DioException catch (e) {
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}

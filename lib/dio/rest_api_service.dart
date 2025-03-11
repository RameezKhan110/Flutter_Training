
import 'package:dio/dio.dart';
import 'package:flutter_training/dio/dio_service.dart';

class RestApiService {

  final dio = DioService().dio;

  Future<Response> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        "3/movie/popular",
        queryParameters: {
          "page": page,
          "language": "en-US"
        },
      );
      return response;
    } on DioError catch (e) {
      // Handle error
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;  // Re-throw the error or handle it appropriately
    }
  }

  Future<Response> getTopRatedMovies(int page) async {
    try {
      final response = await dio.get(
        "3/movie/top_rated",
        queryParameters: {
          "page": page,
          "language": "en-US"
        },
      );
      return response;
    } on DioError catch (e) {
      // Handle error
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;  // Re-throw the error or handle it appropriately
    }
  }
}
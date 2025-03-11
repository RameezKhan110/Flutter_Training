import 'package:dio/dio.dart';
import 'package:flutter_training/dio/dio_service.dart';

class RestApiService {

  final dioService = DioService();

  Future<Response> getPopularMovies(int page) async {
    try {
      final response = await dioService.get("3/movie/popular", queryParams: {"page": page, "language": "en-US",});
      return response;
    } on DioException catch (e) {
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

  Future<Response> getTopRatedMovies(int page) async {
    try {
      final response = await dioService.get(
        "3/movie/top_rated", queryParams: {"page": page, "language": "en-US"});
      return response;
    } on DioException catch (e) {
      print('Error occurred: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }
}

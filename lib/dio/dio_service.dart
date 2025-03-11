
import 'package:dio/dio.dart';

class DioService {

  late Dio _dio;
  DioService()  {
    final options = BaseOptions(
      baseUrl: "https://api.themoviedb.org/",
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 30)
    );

    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add Bearer token to every request
        final token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZjhiZTFiN2Q2YmJjZWFiM2E2NDY4ZDRiNTdjNjhhYSIsIm5iZiI6MTc0MTY0NDM4Mi40NDYsInN1YiI6IjY3Y2Y2MjVlNjY3NmU5OTQwMDExMDk2ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6SgurJPxt35d1uKZU-0ZdDJ6HKE-qOCbaJcd9baRjz8'; // Fetch the token from secure storage or authentication manager
        if (token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioError e, handler) {
        // Handle errors globally here
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
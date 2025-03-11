
import 'package:flutter/material.dart';
import 'package:flutter_training/model/popular_movies.dart';
import 'package:flutter_training/dio/rest_api_service.dart';

class SearchProvider extends ChangeNotifier {

  RestApiService apiService = RestApiService();
  PopularMovies? _popularMovies = PopularMovies();
  PopularMovies? get popularMovies => _popularMovies;

  bool _isPopularMoviesLoading = false;
  bool get isPopularMoviesLoading => _isPopularMoviesLoading;

  Future<void> getPopularMovies(int page) async {
    _isPopularMoviesLoading = true;
    notifyListeners();

    try {
      final response = await apiService.getPopularMovies(page);
      if (response.data != null) {
        _popularMovies = PopularMovies.fromJson(response.data);
        // _upcomingMoviesErrorMessage = "";
        print(_popularMovies?.results?[0].title);
      } else {
        // _upcomingMoviesErrorMessage = "No data received.";
      }
    } catch (e) {
      // _upcomingMoviesErrorMessage = "Failed to load upcoming movies: $e";
      _popularMovies = null;
      print("exception $e");
    }

    _isPopularMoviesLoading = false;
    notifyListeners();
  }
}
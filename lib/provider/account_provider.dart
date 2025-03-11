
import 'package:flutter/cupertino.dart';
import 'package:flutter_training/model/TopRatedMovies.dart';

import '../dio/rest_api_service.dart';

class AccountProvider extends ChangeNotifier {

  RestApiService apiService = RestApiService();
  TopRatedMovies? _topRatedMovies = TopRatedMovies();
  TopRatedMovies? get topRatedMovies => _topRatedMovies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getTopRatedMovies(int page) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await apiService.getTopRatedMovies(page);
      if (response.data != null) {
        _topRatedMovies = TopRatedMovies.fromJson(response.data);
        // _upcomingMoviesErrorMessage = "";
        print(_topRatedMovies?.results?[0].title);
      } else {
        // _upcomingMoviesErrorMessage = "No data received.";
      }
    } catch (e) {
      // _upcomingMoviesErrorMessage = "Failed to load upcoming movies: $e";
      _topRatedMovies = null;
      print("exception $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/model/popular_movies.dart';
import 'package:flutter_training/dio/rest_api_service.dart';

class SearchCubit extends Cubit<SearchApiState> {

  RestApiService apiService = RestApiService();
  PopularMovies? _popularMovies = PopularMovies();

  SearchCubit(this.apiService): super(SearchApiInitial());

  Future<void> getPopularMovies(int page) async {
    emit(SearchApiLoading());
    try {
      final response = await apiService.getPopularMovies(page);
      if (response.data != null) {
        _popularMovies = PopularMovies.fromJson(response.data);
        emit(SearchApiSuccess(_popularMovies!));
        print(_popularMovies?.results?[0].title);
      } else {
      }
    } catch (e) {
      _popularMovies = null;
      emit(SearchApiError("Failed to fetch data"));
      print("exception $e");
    }
  }
}

abstract class SearchApiState {}

class SearchApiInitial extends SearchApiState{}
class SearchApiLoading extends SearchApiState{}
class SearchApiSuccess extends SearchApiState {
  final PopularMovies data;
  SearchApiSuccess(this.data);
}
class SearchApiError extends SearchApiState {
  final String errorMessage;
  SearchApiError(this.errorMessage);
}
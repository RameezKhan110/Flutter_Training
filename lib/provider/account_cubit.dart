
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/model/TopRatedMovies.dart';

import '../dio/rest_api_service.dart';

class AccountCubit extends Cubit<AccountApiState> {

  RestApiService apiService = RestApiService();
  TopRatedMovies? _topRatedMovies = TopRatedMovies();

  AccountCubit(this.apiService): super(AccountApiInitial());

  Future<void> getTopRatedMovies(int page) async {
    emit(AccountApiLoading());
    try {
      final response = await apiService.getTopRatedMovies(page);
      if (response.data != null) {
        _topRatedMovies = TopRatedMovies.fromJson(response.data);
        emit(AccountApiSuccess(_topRatedMovies!));
        print(_topRatedMovies?.results?[0].title);
      }
    } catch (e) {
      _topRatedMovies = null;
      emit(AccountApiError("Failed to get data"));
      print("exception $e");
    }
  }
}

abstract class AccountApiState {}

class AccountApiInitial extends AccountApiState{}
class AccountApiLoading extends AccountApiState{}
class AccountApiSuccess extends AccountApiState {
  final TopRatedMovies data;
  AccountApiSuccess(this.data);
}
class AccountApiError extends AccountApiState {
  final String errorMessage;
  AccountApiError(this.errorMessage);
}

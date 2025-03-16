import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_training/model/product_model.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';
import 'package:get_storage/get_storage.dart';

// class RemoteConfigProvider extends ChangeNotifier {
//   final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
//
//   bool _isLoading = true;
//
//   bool get isLoading => _isLoading;
//
//   List<String>? _categories = [];
//
//   List<String>? get categories => _categories;
//
//   List<String>? _designers = [];
//
//   List<String>? get designers => _designers;
//
//   List<ProductModel>? _products = [];
//
//   List<ProductModel>? get products => _products;
//
//   GetStorageHelper getStorageHelper = GetStorageHelper();
//
//   RemoteConfigProvider() {
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     await _remoteConfig.setConfigSettings(
//       RemoteConfigSettings(
//         fetchTimeout: Duration(minutes: 2),
//         minimumFetchInterval: Duration.zero,
//       ),
//     );
//     await _fetchConfig();
//   }
//
//   Future<void> _fetchConfig() async {
//     try {
//       await _remoteConfig.fetchAndActivate();
//
//       getStorageHelper.writeStorage("base_url", _remoteConfig.getString("base_url"));
//       getStorageHelper.writeStorage("platzi_base_url", _remoteConfig.getString("platzi_base_url"));
//       getStorageHelper.writeStorage("bearer_token", _remoteConfig.getString("bearer_token"));
//
//       final String endpointsJsonStr = _remoteConfig.getString("end_points");
//       Map<String, dynamic> endpointsMap = jsonDecode(endpointsJsonStr);
//       getStorageHelper.writeStorage("popular_movies", endpointsMap["popular_movies"]);
//       getStorageHelper.writeStorage("top_rated_movies", endpointsMap["top_rated_movies"]);
//       getStorageHelper.writeStorage("platzi_upload_file", endpointsMap["platzi_upload_file"]);
//
//       String categoriesJsonStr = _remoteConfig.getString("categories");
//       Map<String, dynamic> categoriesMap = jsonDecode(categoriesJsonStr);
//       _categories = List<String>.from(categoriesMap['my_categories']);
//
//       String designersJsonStr = _remoteConfig.getString("designers");
//       Map<String, dynamic> designersMap = jsonDecode(designersJsonStr);
//       _designers = List<String>.from(designersMap['my_designers']);
//
//       String productsJsonStr = _remoteConfig.getString("products");
//       Map<String, dynamic> productsMap = jsonDecode(productsJsonStr);
//       List<dynamic> productsList = productsMap['products'];
//       _products =
//           productsList.map((json) => ProductModel.fromJson(json)).toList();
//
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       print("Error fetching remote config $e}");
//     }
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:convert';

class RemoteConfigCubit extends Cubit<RemoteConfigState> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final GetStorageHelper getStorageHelper = GetStorageHelper();

  RemoteConfigCubit() : super(RemoteConfigState(isLoading: true));

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: Duration(minutes: 2),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await _fetchConfig();
  }

  Future<void> _fetchConfig() async {
    try {
      emit(state.copyWith(isLoading: true));

      await _remoteConfig.fetchAndActivate();

      getStorageHelper.writeStorage("base_url", _remoteConfig.getString("base_url"));
      getStorageHelper.writeStorage("platzi_base_url", _remoteConfig.getString("platzi_base_url"));
      getStorageHelper.writeStorage("bearer_token", _remoteConfig.getString("bearer_token"));

      final String endpointsJsonStr = _remoteConfig.getString("end_points");
      Map<String, dynamic> endpointsMap = jsonDecode(endpointsJsonStr);
      getStorageHelper.writeStorage("popular_movies", endpointsMap["popular_movies"]);
      getStorageHelper.writeStorage("top_rated_movies", endpointsMap["top_rated_movies"]);
      getStorageHelper.writeStorage("platzi_upload_file", endpointsMap["platzi_upload_file"]);

      String categoriesJsonStr = _remoteConfig.getString("categories");
      Map<String, dynamic> categoriesMap = jsonDecode(categoriesJsonStr);
      List<String> categories = List<String>.from(categoriesMap['my_categories']);

      String designersJsonStr = _remoteConfig.getString("designers");
      Map<String, dynamic> designersMap = jsonDecode(designersJsonStr);
      List<String> designers = List<String>.from(designersMap['my_designers']);

      String productsJsonStr = _remoteConfig.getString("products");
      Map<String, dynamic> productsMap = jsonDecode(productsJsonStr);
      List<dynamic> productsList = productsMap['products'];
      List<ProductModel> products =
      productsList.map((json) => ProductModel.fromJson(json)).toList();

      print("data fetched from remote config");
      emit(state.copyWith(
        isLoading: false,
        categories: categories,
        designers: designers,
        products: products,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: "Error fetching remote config: $e",
      ));
      print("Error fetching remote config $e");
    }
  }
}


class RemoteConfigState {
  final bool isLoading;
  final List<String>? categories;
  final List<String>? designers;
  final List<ProductModel>? products;
  final String? errorMessage;

  RemoteConfigState({
    required this.isLoading,
    this.categories,
    this.designers,
    this.products,
    this.errorMessage,
  });

  RemoteConfigState copyWith({
    bool? isLoading,
    List<String>? categories,
    List<String>? designers,
    List<ProductModel>? products,
    String? errorMessage,
  }) {
    return RemoteConfigState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      designers: designers ?? this.designers,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
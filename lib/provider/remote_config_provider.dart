import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_training/model/product_model.dart';
import 'package:flutter_training/utils/get_storage_helper.dart';
import 'package:get_storage/get_storage.dart';

class RemoteConfigProvider extends ChangeNotifier {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  List<String>? _categories = [];

  List<String>? get categories => _categories;

  List<String>? _designers = [];

  List<String>? get designers => _designers;

  List<ProductModel>? _products = [];

  List<ProductModel>? get products => _products;

  GetStorageHelper getStorageHelper = GetStorageHelper();

  RemoteConfigProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
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
      await _remoteConfig.fetchAndActivate();

      getStorageHelper.writeStorage("base_url", _remoteConfig.getString("base_url"));
      getStorageHelper.writeStorage("bearer_token", _remoteConfig.getString("bearer_token"));

      String categoriesJsonStr = _remoteConfig.getString("categories");
      Map<String, dynamic> categoriesMap = jsonDecode(categoriesJsonStr);
      _categories = List<String>.from(categoriesMap['my_categories']);

      String designersJsonStr = _remoteConfig.getString("designers");
      Map<String, dynamic> designersMap = jsonDecode(designersJsonStr);
      _designers = List<String>.from(designersMap['my_designers']);

      String productsJsonStr = _remoteConfig.getString("products");
      Map<String, dynamic> productsMap = jsonDecode(productsJsonStr);
      List<dynamic> productsList = productsMap['products'];
      _products =
          productsList.map((json) => ProductModel.fromJson(json)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      print("Error fetching remote config $e}");
    }
  }
}

import 'package:flutter/material.dart';

import '../features/account/account_page.dart';
import '../features/cart/cart_page.dart';
import '../features/home/home_page.dart';
import '../features/search/search_page.dart';

class BottomNavProvider extends ChangeNotifier {
  final pages = [Homepage(), SearchPage(), CartPage(), AccountPage()];
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  void changePageIndex(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}

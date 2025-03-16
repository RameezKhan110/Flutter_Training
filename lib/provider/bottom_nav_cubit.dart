import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../features/account/account_page.dart';
import '../features/cart/cart_page.dart';
import '../features/home/home_page.dart';
import '../features/search/search_page.dart';

class BottomNavState {
  final int pageIndex;

  BottomNavState(this.pageIndex);
}

class BottomNavCubit extends Cubit<BottomNavState> {

  BottomNavCubit() : super(BottomNavState(0));

  final List<Widget> pages = [
    Homepage(),
    SearchPage(),
    CartPage(),
    AccountPage(),
  ];

  void changePageIndex(int index) {
    emit(BottomNavState(index));
  }

  int get pageIndex => state.pageIndex;
}
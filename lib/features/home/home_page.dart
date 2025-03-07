import 'package:flutter/material.dart';
import 'package:flutter_training/features/home/category_detail_page.dart';
import 'package:flutter_training/features/home/home_header.dart';
import 'package:flutter_training/utils/app_fonts.dart';
import 'package:flutter_training/utils/app_strings.dart';

import '../cart/cart_page.dart';
import 'home_categories_listview.dart';
import 'home_designer_listview.dart';
import 'home_products_listview.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              HomeHeader(),

              SizedBox(height: 30),

              CategoriesListView(),

              SizedBox(height: 20),

              ProductsListView(),

              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: LanguageText(
                  "designerNearYou",
                  style: TextStyle(
                    fontWeight: FontWeights.boldFontWeight,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(height: 10),

              DesignersListView(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

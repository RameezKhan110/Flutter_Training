import 'package:flutter/material.dart';
import 'package:flutter_training/features/home/category_detail_page.dart';
import 'package:flutter_training/provider/remote_config_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_strings.dart';
import '../cart/cart_page.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteConfigProvider>(
      builder:
          ((context, provider, child) => SizedBox(
                    height: 40,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ItemCategory(name: provider.categories![index]);
                      },
                      itemCount: provider.categories!.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 5);
                      },
                    ),
                  )),
    );
  }
}

class ItemCategory extends StatelessWidget {
  final String name;

  const ItemCategory({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: LanguageText(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeights.mediumFontWeight,
        ),
      ),
    );
  }
}

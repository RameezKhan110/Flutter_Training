import 'package:flutter/material.dart';
import 'package:flutter_training/features/home/category_detail_page.dart';
import 'package:flutter_training/navigation/app_paths.dart';
import 'package:go_router/go_router.dart';
import '../../model/product_model.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../cart/cart_page.dart';

class ItemProduct extends StatelessWidget {
  final String productImage, productName;

  const ItemProduct({
    super.key,
    required this.productImage,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 200,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: Image.asset(
                  productImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 20, top: 10, right: 5),
                child: LanguageText(
                  textAlign: TextAlign.start,
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeights.boldFontWeight,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var productsList = [
      ProductModel(
        productImage: AppImages.yellowInteriorImage,
        productName: "yellowThemeInterior",
      ),
      ProductModel(
        productImage: AppImages.interiorImage,
        productName: "themeInterior",
      ),
      ProductModel(
        productImage: AppImages.interiorImage,
        productName: "themeInterior",
      ),
    ];

    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                context.push(AppPaths.categoryDetail);
              },
              child: ItemProduct(
                productImage: productsList[index].productImage,
                productName: productsList[index].productName,
              )
          );

        },
        itemCount: productsList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 20);
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_training/features/home/category_detail_page.dart';

import '../../utils/app_fonts.dart';
import '../../utils/app_images.dart';
import '../cart/cart_page.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LanguageText(
            softWrap: true,
            "helloJack",
            style: TextStyle(
              fontWeight: FontWeights.boldFontWeight,
              fontSize: 26,
            ),
          ),
        ),

        IconButton(
          onPressed: () {
            print("clicked filter");
          },
          icon: Image.asset(
            AppImages.filterImage,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
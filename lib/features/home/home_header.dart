import 'package:flutter/material.dart';
import 'package:flutter_training/navigation/app_paths.dart';
import 'package:go_router/go_router.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            softWrap: true,
            "${AppStrings.hello},\n${AppStrings.userName}",
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
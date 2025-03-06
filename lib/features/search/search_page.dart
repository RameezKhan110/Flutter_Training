import 'package:flutter/material.dart';
import 'package:flutter_training/utils/app_fonts.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "This is search screen",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeights.boldFontWeight,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

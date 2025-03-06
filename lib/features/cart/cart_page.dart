import 'package:flutter/material.dart';
import '../../utils/app_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "This is cart screen",
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
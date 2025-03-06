import 'package:flutter/material.dart';

import '../../utils/app_fonts.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "This is account screen",
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
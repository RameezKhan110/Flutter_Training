import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartStatePage();
  }
}

class _CartStatePage extends State<CartPage> {
  String currentLanguage = "en";

  void changeLanguage() {
    setState(() {
      currentLanguage = context.locale.languageCode == 'en' ? 'ar' : 'en';
    });
    context.setLocale(Locale(currentLanguage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const LanguageText("cartScreen")),
      body: SafeArea(
        child: Card(
          color: AppColors.colorWhite,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.language),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    changeLanguage();
                  },
                  child: LanguageText(
                    currentLanguage == 'en' ? 'english' : 'arabic',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageText extends StatelessWidget {
  final String textKey;
  final TextStyle? style;
  final bool? softWrap;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const LanguageText(
      this.textKey, {
        super.key,
        this.style,
        this.textAlign,
        this.softWrap,
        this.maxLines,
        this.overflow,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: softWrap,
      textKey.tr(),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

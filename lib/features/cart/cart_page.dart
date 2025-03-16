import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/dio/dio_service.dart';
import 'package:flutter_training/provider/cart_cubit.dart';
import 'package:flutter_training/utils/app_fonts.dart';
import 'package:flutter_training/utils/file_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("Cart Page")),
      body: BlocBuilder<CartCubit, CartApiState>(
        builder: (context, state) {
          return Column(
            children: [
              Card(
                color: AppColors.colorWhite,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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

              SizedBox(height: 20),

              SizedBox(
                height: 200,
                child: InkWell(
                  onTap: () async {
                    selectedImage = await FileUtils().pickImage();
                    // setState(() {});
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        selectedImage == null
                            ? Center(
                              child: Text(
                                "Click to select image",
                                style: TextStyle(
                                  fontWeight: FontWeights.mediumFontWeight,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            )
                            : Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedImage == null) {
                        Fluttertoast.showToast(
                          msg: "Please select image first",
                          toastLength: Toast.LENGTH_SHORT,
                          // Length of toast
                          gravity: ToastGravity.BOTTOM,
                          // Position of toast
                          backgroundColor: Colors.grey,
                          // Background color of the toast
                          textColor: Colors.white,
                          // Text color of the toast
                          fontSize: 14.0, // Font size
                        );
                        return;
                      }

                      Uint8List? bytes = await selectedImage?.readAsBytes();
                      cubit.fileUpload(bytes!, "file.jpg");
                    },
                    child:
                        state is CartApiLoading
                            ? Padding(
                              padding: const EdgeInsets.all(15),
                              child: CircularProgressIndicator(),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text("Upload Image"),
                            ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              state is CartApiSuccess ? SizedBox(child: Text(state.data)): Container()
            ],
          );
        },
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

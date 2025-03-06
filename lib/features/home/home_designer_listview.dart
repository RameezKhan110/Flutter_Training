import 'package:flutter/material.dart';
import '../../utils/app_images.dart';

class ItemDesigner extends StatelessWidget {
  final String designerImage;

  const ItemDesigner({super.key, required this.designerImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(designerImage, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class DesignersListView extends StatelessWidget {
  const DesignersListView({super.key});

  @override
  Widget build(BuildContext context) {
    var designersList = [
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage,
      AppImages.designerImage
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ItemDesigner(designerImage: designersList[index]);
        },
        itemCount: designersList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 5);
        },
      ),
    );
  }
}
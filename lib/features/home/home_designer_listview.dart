import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/remote_config_provider.dart';
import 'package:provider/provider.dart';
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
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: designerImage,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
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

    return Consumer<RemoteConfigProvider>(
      builder: ( (context, provider, child) => SizedBox(
        height: 80,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ItemDesigner(designerImage: provider.designers![index]);
          },
          itemCount: provider.designers!.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(width: 5);
          },
        ),
      )),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Кэширование картинок, реализован подключенный пакет
class PersonCacheImage extends StatelessWidget {
  final String imageUrl;
  final double widht, height;

  const PersonCacheImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.widht,
  }) : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      width: widht,
      height: height,
      imageBuilder: (context, imageProvider) {
        return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return _imageWidget(const AssetImage('assets/images/noimage.jpg'));
      },
    );
  }
}

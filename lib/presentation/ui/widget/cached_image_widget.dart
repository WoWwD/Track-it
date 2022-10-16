import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum TypeCachedImage {
  small24,
  medium36,
  large48
}

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final TypeCachedImage typeCachedImage;
  final double borderRadius;

  const CachedImage({
    Key? key,
    required this.imageUrl,
    required this.typeCachedImage,
    this.borderRadius = 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (typeCachedImage) {
      case TypeCachedImage.small24:
        return SizedBox(height: 24, width: 24, child: _getImage());
      case TypeCachedImage.medium36:
        return SizedBox(height: 36, width: 36, child: _getImage());
      case TypeCachedImage.large48:
        return SizedBox( height: 48, width: 48, child: _getImage());
    }
  }

  Widget _getImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
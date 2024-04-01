import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/res/res.dart';

class AppCachedImage extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  final double width, height;
  final BoxFit? fit;
  final Color? borderColor;
  final double? borderWidth;
  final bool isCircular;
  final File? localFile;

  const AppCachedImage({
    this.imageUrl,
    this.width = 90,
    this.height = 90,
    this.radius,
    this.fit,
    this.borderColor,
    this.borderWidth,
    this.localFile,
    this.isCircular = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (localFile == null && imageUrl == null) {
      return const SizedBox();
    }
    return Container(
      decoration: BoxDecoration(
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor ?? Theme.of(context).primaryColor,
                width: borderWidth ?? 0,
              ),
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular
            ? null
            : BorderRadius.only(
                topLeft: Radius.circular(radius ?? 12),
                topRight: Radius.circular(radius ?? 12),
                bottomLeft: Radius.circular(radius ?? 12),
                bottomRight: Radius.circular(radius ?? 12),
              ),
      ),
      child: localFile != null
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isCircular
                    ? null
                    : BorderRadius.only(
                        topLeft: Radius.circular(radius ?? 12),
                        topRight: Radius.circular(radius ?? 12),
                        bottomLeft: Radius.circular(radius ?? 12),
                        bottomRight: Radius.circular(radius ?? 12),
                      ),
                image: DecorationImage(
                  image: FileImage(localFile!),
                  fit: fit ?? BoxFit.cover,
                ),
              ),
            )
          : CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: isCircular
                      ? null
                      : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
              ),
              imageUrl: imageUrl ?? 'image not found',
              width: width,
              height: height,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: SizedBox(
                  height: height / 4,
                  width: height / 4,
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Theme.of(context).primaryColor,
                    strokeWidth: 2.0,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: isCircular
                      ? null
                      : BorderRadius.only(
                          topLeft: Radius.circular(radius ?? 12),
                          topRight: Radius.circular(radius ?? 12),
                          bottomLeft: Radius.circular(radius ?? 12),
                          bottomRight: Radius.circular(radius ?? 12),
                        ),
                  image: DecorationImage(
                    image: const AssetImage(Res.logoImage),
                    fit: fit ?? BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.grey.shade400,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

loadImage({url, double? height, double? width}) {
  return Container(
    width: width,
    height: height,
    child: CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
          ),
        ),
      ),
      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
  );
}

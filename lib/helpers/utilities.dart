import 'package:flutter/material.dart';
import 'package:sasMovie/api/core/APIConstants.dart';

///Network Load Image
Image loadImage(String imageUrl) {
  return Image.network(
    APIConstants.API_IMAGE_PATH + imageUrl,
    fit: BoxFit.cover,
    width: 1000.0,
  );
}

///Network Load Image Oppocity
Image loadImageOpacity(String imageUrl, double opacity) {
  return Image.network(APIConstants.API_IMAGE_PATH + imageUrl,
      fit: BoxFit.cover,
      width: 1000.0,
      color: Color.fromRGBO(255, 255, 255, opacity),
      colorBlendMode: BlendMode.modulate);
}

/// Image Radius Card;
///
/// item: Image Url,
///
/// radius: Card Radius
Container imageCard(String imageUrl, double radius) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: loadImage(imageUrl),
    ),
  );
}

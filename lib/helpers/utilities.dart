import 'package:flutter/material.dart';
import 'package:sasMovie/api/core/APIConstants.dart';
import 'package:url_launcher/url_launcher.dart';

///Show browse url
showBrowse(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

///Network Load Image
Image loadImage(String imageUrl) {
  return Image.network(
    imageUrl,
    fit: BoxFit.cover,
    width: 1000.0,
  );
}

///Api Load Image
Image loadApiImage(String imageUrl) {
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
  if(imageUrl==null) return Container();
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: loadApiImage(imageUrl),
    ),
  );
}

///SecondTo xH ym
///
///second: Total second
String secondToDuration(int second) {
  var hours = (second / 60).toString().split('.')[0];
  var minutes = second % 60;
  return hours.toString() + "h " + minutes.toString() + "m";
}

import 'package:flutter/material.dart';

class TextCenter extends StatelessWidget {
  final String text;
  TextCenter({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}

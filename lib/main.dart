import 'package:flutter/material.dart';
import 'ui/movie_list/list_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(fontFamily: 'Conduit'),
      initialRoute: "/home",
      routes: {
        "/home": (context) => MovieList(),
      },
    );
  }
}

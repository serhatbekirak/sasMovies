import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sasMovie/helpers/utilities.dart';
import 'package:sasMovie/ui/movie_detail/detail_main.dart';
import 'package:sasMovie/widgets/CarouselImageWidget/CarouselImageModel.dart';

class CarouselImageWidget extends StatefulWidget {
  final List<CarouselImageModel> list;

  CarouselImageWidget(this.list, {Key key}) : super(key: key);

  @override
  _CarouselImageWidgetState createState() => _CarouselImageWidgetState(list);
}

class _CarouselImageWidgetState extends State<CarouselImageWidget> {
  List<CarouselImageModel> list;
  int current;

  _CarouselImageWidgetState(this.list);

  @override
  void initState() {
    super.initState();
    this.current = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            carouselSliderWidget(),
            imagelistDotIndicatorWidget(),
          ],
        ));
  }

  CarouselSlider carouselSliderWidget() {
    return CarouselSlider(
      items: list
          .map(
            (item) => GestureDetector(
              child: imageCard(item.imagePath, 20.0),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetail(movieId: item.id),
                  ),
                );
              },
            ),
          )
          .toList(),
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {
          setState(() {
            current = index;
          });
        },
      ),
    );
  }

  Row imagelistDotIndicatorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list.map((url) {
        int index = list.indexOf(url);
        return Container(
          width: 15.0,
          height: 5.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: (current == index) ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}

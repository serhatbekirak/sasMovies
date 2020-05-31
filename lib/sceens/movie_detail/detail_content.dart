import 'package:flutter/material.dart';
import 'package:sasMovie/blocs/movieDetailBloc.dart';
import 'package:sasMovie/helpers/utilities.dart';
import 'package:intl/intl.dart';
import 'package:sasMovie/models/movieDetailModel.dart';

class DetailContent extends StatelessWidget {
  final MovieDetailBloc bloc;
  final MovieDetailModel movieDetail;
  final DateFormat formatter = new DateFormat('yyyy-MM-dd');

  DetailContent({Key key, @required this.movieDetail, @required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 230.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: _appBarTitle(),
              background: _appBarBackground(),
            ),
          ),
        ];
      },
      body: _detailContent(),
    );
  }

  Stack _appBarBackground() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: loadImageOpacity(movieDetail.backdropPath, 0.4),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        height: 200,
                        width: 150,
                        child: imageCard(movieDetail.posterPath, 10.0),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Text _appBarTitle() {
    return Text(
        movieDetail.title +
            " (" +
            formatter.parse(movieDetail.releaseDate).year.toString() +
            ")",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        ));
  }

  Container _detailContent() => Container();
}

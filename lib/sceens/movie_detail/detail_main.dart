import 'package:flutter/material.dart';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/blocs/movieDetailBloc.dart';
import 'package:sasMovie/models/movieDetailModel.dart';
import 'package:sasMovie/sceens/movie_detail/detail_content.dart';
import 'package:sasMovie/widgets/LoadingCenter.dart';
import 'package:sasMovie/widgets/TextCenter.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  MovieDetail({Key key, @required this.movieId}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState(movieId);
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _bloc;
  int _movieId;

  _MovieDetailState(int movieId) {
    this._movieId = movieId;
  }

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailBloc(_movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<APIResponse<MovieDetailModel>>(
          stream: _bloc.dataStream,
          builder:
              (context, AsyncSnapshot<APIResponse<MovieDetailModel>> snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return LoadingCenter();
                  break;
                case Status.COMPLETED:
                  return DetailContent(
                      movieDetail: snapshot.data.data, bloc: _bloc);
                  break;
                case Status.ERROR:
                  return TextCenter(text: snapshot.data.message);
                  break;
              }
            }
            return TextCenter(text: "Error");
          },
        ),
      ),
    );
  }
}

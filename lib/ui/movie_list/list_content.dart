import 'package:flutter/material.dart';
import 'package:sasMovie/helpers/utilities.dart';
import 'package:sasMovie/models/movieModel.dart';
import 'package:sasMovie/ui/movie_detail/detail_main.dart';
import 'package:sasMovie/widgets/CarouselImageWidget/CarouselImageModel.dart';
import 'package:sasMovie/widgets/CarouselImageWidget/CarouselImageWidget.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListContent extends StatefulWidget {
  final List<MovieModel> movieList;

  ListContent({Key key, @required this.movieList}) : super(key: key);

  @override
  _ListContentState createState() => _ListContentState(movieList);
}

class _ListContentState extends State<ListContent> {
  final List<MovieModel> _movieList;
  List<CarouselImageModel> _imageList = new List<CarouselImageModel>();

  _ListContentState(this._movieList) {
    for (var value in this._movieList) {
      _imageList.add(new CarouselImageModel(value.backdropPath, value.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselImageWidget(_imageList),
        MovieListWidget(movieList: _movieList),
      ],
    );
  }
}

class MovieListWidget extends StatefulWidget {
  final List<MovieModel> movieList;
  MovieListWidget({Key key, this.movieList}) : super(key: key);

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState(movieList);
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final List<MovieModel> movieList;
  _MovieListWidgetState(this.movieList);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: listViewItem(context, index),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MovieDetail(movieId: movieList[index].id)));
            },
          );
        },
      ),
    );
  }

  Container listViewItem(BuildContext context, int index) {
    return Container(
      height: 150,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.25,
              child: imageCard(
                movieList[index].posterPath,
                10.0,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.70,
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.03, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movieList[index].title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SmoothStarRating(
                          starCount: 10,
                          rating: double.parse(movieList[index].voteAverage),
                          isReadOnly: true,
                          size: 20,
                          color: Colors.orange,
                          borderColor: Colors.orange,
                          allowHalfRating: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                            movieList[index].voteAverage,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      movieList[index].overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      movieList[index].releaseDate,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

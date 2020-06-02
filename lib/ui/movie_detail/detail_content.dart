import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/blocs/movieDetailBloc.dart';
import 'package:sasMovie/helpers/colors.dart';
import 'package:sasMovie/helpers/utilities.dart';
import 'package:intl/intl.dart';
import 'package:sasMovie/models/MovieCreditModel.dart';
import 'package:sasMovie/models/movieDetailModel.dart';
import 'package:sasMovie/widgets/LoadingCenter.dart';
import 'package:sasMovie/widgets/TextCenter.dart';

class DetailContent extends StatelessWidget {
  final MovieDetailBloc bloc;
  final MovieDetailModel movieDetail;
  final DateFormat formatter = new DateFormat('yyyy-MM-dd');
  bool _creditsStatus = false;

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
            backgroundColor: darkBg,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: _appBarTitle(),
              background: _appBarBackground(),
            ),
          ),
        ];
      },
      body: _detailContent(context),
    );
  }

  Widget _appBarBackground() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: darkBg,
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

  Widget _detailContent(BuildContext context) => SingleChildScrollView(
        child: GestureDetector(
          onPanDown: (details) {
            if (!_creditsStatus) {
              _creditsStatus = true;
              bloc.fetchCredist(movieDetail.id);
            }
          },
          child: Column(
            children: <Widget>[
              Container(
                color: darkBg,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: MediaQuery.of(context).size.width * 0.48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CircularPercentIndicator(
                            radius: 60.0,
                            lineWidth: 5.0,
                            percent: movieDetail.voteAverage / 10,
                            center: new Text(
                              ((movieDetail.voteAverage * 10).round())
                                      .toString() +
                                  "%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            progressColor: Colors.yellow,
                            backgroundColor: blackBg,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 65,
                            child: Text(
                              "Member Points",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      child: VerticalDivider(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        showBrowse(
                            "https://www.imdb.com/title/" + movieDetail.imdbId);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Icon(Icons.play_arrow, color: Colors.white),
                            ),
                            Text(
                              "Open IMDb",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                color: blackBg,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Text(
                            "R",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          movieDetail.releaseDate +
                              " (" +
                              movieDetail.originalLanguage.toUpperCase() +
                              ")",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                        Text(
                          secondToDuration(movieDetail.runtime),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                    Text(
                      movieDetail.genres.fold(
                          "",
                          (previousValue, element) =>
                              previousValue + element.name + "  "),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                color: darkBg,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            movieDetail.tagline,
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Summary",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                          child: Text(
                            movieDetail.overview,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Lead actors",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: StreamBuilder<APIResponse<MovieCreditModel>>(
                        stream: bloc.creditStream,
                        builder: (context,
                            AsyncSnapshot<APIResponse<MovieCreditModel>>
                                snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data.status) {
                              case Status.LOADING:
                                return LoadingCenter();
                                break;
                              case Status.COMPLETED:
                                return CreditsWidget(
                                    credits: snapshot.data.data);
                                break;
                              case Status.ERROR:
                                return TextCenter(text: snapshot.data.message);
                                break;
                            }
                          }
                          return TextCenter(text: "Scroll to load");
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

class CreditsWidget extends StatelessWidget {
  final MovieCreditModel credits;

  const CreditsWidget({
    Key key,
    this.credits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: credits.cast.length,
          itemBuilder: (BuildContext context, int index) => Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: credits.cast[index].profilePath == null
                      ? (credits.cast[index].gender == 1
                          ? loadImage(
                              "https://uns.com.tr/wp-content/uploads/2018/04/blank-user-355ba8nijgtrgca9vdzuv41.jpg")
                          : loadImage(
                              "https://www.juventud.gob.do/wp-content/uploads/2013/07/avatar-none-F-400x380.jpg"))
                      : loadApiImage(credits.cast[index].profilePath),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    credits.cast[index].name,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(credits.cast[index].character),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/blocs/movieListBloc.dart';
import 'package:sasMovie/models/movieModel.dart';
import 'package:sasMovie/widgets/CircleTabIndicator.dart';
import 'package:sasMovie/widgets/LoadingCenter.dart';
import 'package:sasMovie/widgets/TextCenter.dart';

import 'list_content.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  MovieListBloc _bloc;
  Widget appBarTitle;
  Icon appBarAction;
  int tabBarLenght;
  int _selectedTab;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.initState();
    this._bloc = MovieListBloc();
    this.appBarTitle = titleText;
    this.appBarAction = searchIcon;
    this._selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _searchAppBar(),
        body: Container(
          child: StreamBuilder<APIResponse<List<MovieModel>>>(
            stream: _bloc.dataStream,
            builder: (context,
                AsyncSnapshot<APIResponse<List<MovieModel>>> snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return LoadingCenter();
                    break;
                  case Status.COMPLETED:
                    return ListContent(movieList: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    return TextCenter(text: snapshot.data.message);
                    break;
                }
              }
              return Center(child: Text("Error"));
            },
          ),
        ),
      ),
    );
  }

  AppBar _searchAppBar() {
    return new AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: appBarTitle,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              if (this.appBarAction.icon == Icons.search) {
                this.appBarAction = clearIcon;
                this.appBarTitle = searchTextInput;
              } else {
                this.appBarAction = searchIcon;
                this.appBarTitle = titleText;
              }
            });
          },
          icon: appBarAction,
        )
      ],
      bottom: TabBar(
        indicator: CircleTabIndicator(color: Colors.blue, radius: 3),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          Tab(
            child: Text(
              'Recommend',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Tab(
            child: Text(
              'popular',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Tab(
            child: Text(
              'Upcoming',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
        onTap: (index) {
          if (_selectedTab != index) {
            _selectedTab = index;
            if (index == 0) _bloc.fetchRecommend();
            if (index == 1) _bloc.fetchPopular();
            if (index == 2) _bloc.fetchUpcoming();
          }
        },
      ),
    );
  }

  /// Icon: search, Color: Black, Size: 30
  Icon searchIcon = Icon(Icons.search, color: Colors.black, size: 30);

  /// Icon: search, Color: Black, Size: 30
  Icon clearIcon = Icon(Icons.clear, color: Colors.black, size: 30);

  /// Text: Movies, Color: Black, Size: 40, Weight:Bold, Style:Italic, Family: Conduit
  Widget titleText = Text(
    'Movies',
    style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 40),
  );

  /// Hint: Search Movie, Color: Black, Size: 30, Border:none
  Widget searchTextInput = TextField(
    textInputAction: TextInputAction.go,
    decoration:
        InputDecoration(border: InputBorder.none, hintText: "Search Movie"),
    style: TextStyle(color: Colors.black, fontSize: 30),
  );
}

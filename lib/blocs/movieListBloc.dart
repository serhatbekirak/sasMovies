import 'dart:async';

import 'package:sasMovie/api/requests/RecommendRequest.dart';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/api/requests/popularRequest.dart';
import 'package:sasMovie/api/requests/upcomingRequest.dart';
import 'package:sasMovie/models/movieModel.dart';

class MovieListBloc {
  RecommendRequest _recommendRequest;
  PopularRequest _popularRequest;
  UpcomingRequest _upcomingRequest;
  StreamController _dataController;
  bool _isStreaming;

  StreamSink<APIResponse<List<MovieModel>>> get dataSink => _dataController.sink;

  Stream<APIResponse<List<MovieModel>>> get dataStream => _dataController.stream;

  MovieListBloc() {
    _dataController = StreamController<APIResponse<List<MovieModel>>>();
    _recommendRequest = RecommendRequest();
    _popularRequest = PopularRequest();
    _upcomingRequest = UpcomingRequest();
    _isStreaming = true;
    fetchRecommend();
  }

  fetchRecommend() async {
    dataSink.add(APIResponse.loading('Getting a Recommend!'));
    try {
      List<MovieModel> movieList = await _recommendRequest.fetchRecommendList();
      if (_isStreaming) {
        dataSink.add(APIResponse.completed(movieList));
      }
    } catch (e) {
      if (_isStreaming) {
        dataSink.add(APIResponse.error(e.toString()));
      }
    }
  }

  fetchPopular() async {
    dataSink.add(APIResponse.loading('Getting a Popular!'));
    try {
      List<MovieModel> movieList = await _popularRequest.fetchPopularList();
      if (_isStreaming) {
        dataSink.add(APIResponse.completed(movieList));
      }
    } catch (e) {
      if (_isStreaming) {
        dataSink.add(APIResponse.error(e.toString()));
      }
    }
  }

  fetchUpcoming() async {
    dataSink.add(APIResponse.loading('Getting a Upcoming!'));
    try {
      List<MovieModel> movieList = await _upcomingRequest.fetchUpcomingList();
      if (_isStreaming) {
        dataSink.add(APIResponse.completed(movieList));
      }
    } catch (e) {
      if (_isStreaming) {
        dataSink.add(APIResponse.error(e.toString()));
      }
    }
  }

  dispose() {
    _isStreaming = false;
    _dataController?.close();
  }
}

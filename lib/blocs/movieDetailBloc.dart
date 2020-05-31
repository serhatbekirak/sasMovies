import 'dart:async';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/api/requests/detailRequest.dart';
import 'package:sasMovie/models/movieDetailModel.dart';

class MovieDetailBloc {
  DetailRequest _detailRequest;
  StreamController _dataController;
  bool _isStreaming;

  StreamSink<APIResponse<MovieDetailModel>> get dataSink => _dataController.sink;

  Stream<APIResponse<MovieDetailModel>> get dataStream => _dataController.stream;

  MovieDetailBloc(int movieId) {
    _dataController = StreamController<APIResponse<MovieDetailModel>>();
    _detailRequest = DetailRequest();
    _isStreaming = true;
    fetchDetail(movieId);
  }

  fetchDetail(int movieId) async {
    dataSink.add(APIResponse.loading('Getting a Detail!'));
    try {
      MovieDetailModel movieDetail = await _detailRequest.fetchDetail(movieId);
      if (_isStreaming) {
        dataSink.add(APIResponse.completed(movieDetail));
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

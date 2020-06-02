import 'dart:async';
import 'package:sasMovie/api/core/APIResponse.dart';
import 'package:sasMovie/api/requests/creditsRequest.dart';
import 'package:sasMovie/api/requests/detailRequest.dart';
import 'package:sasMovie/models/MovieCreditModel.dart';
import 'package:sasMovie/models/movieDetailModel.dart';

class MovieDetailBloc {
  DetailRequest _detailRequest;
  CreditsRequest _creditsRequest;
  StreamController _detailController;
  StreamController _creditsController;
  bool _isStreaming;

  StreamSink<APIResponse<MovieDetailModel>> get dataSink =>
      _detailController.sink;

  Stream<APIResponse<MovieDetailModel>> get dataStream =>
      _detailController.stream;

  StreamSink<APIResponse<MovieCreditModel>> get creditsSink =>
      _creditsController.sink;

  Stream<APIResponse<MovieCreditModel>> get creditStream =>
      _creditsController.stream;

  MovieDetailBloc(int movieId) {
    _detailController = StreamController<APIResponse<MovieDetailModel>>();
    _creditsController = StreamController<APIResponse<MovieCreditModel>>();
    _detailRequest = DetailRequest();
    _creditsRequest = CreditsRequest();
    _isStreaming = true;
    fetchDetail(movieId);
    // fetchCredist(movieId);
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

  fetchCredist(int movieId) async {
    creditsSink.add(APIResponse.loading('Getting a Credists!'));
    try {
      MovieCreditModel movieDetail =
          await _creditsRequest.fetchCredits(movieId);
      if (_isStreaming) {
        creditsSink.add(APIResponse.completed(movieDetail));
      }
    } catch (e) {
      if (_isStreaming) {
        creditsSink.add(APIResponse.error(e.toString()));
      }
    }
  }

  dispose() {
    _isStreaming = false;
    _detailController?.close();
  }
}

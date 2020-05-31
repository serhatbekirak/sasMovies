import 'dart:async';
import 'package:sasMovie/api/core/APIManager.dart';
import 'package:sasMovie/models/movieDetailModel.dart';

class DetailRequest {
  APIManager _apiManager = APIManager();

  Future<MovieDetailModel> fetchDetail(int movieId) async {
    final response = await _apiManager.get(method: movieId.toString());
    return MovieDetailModel.fromJson(response);
  }
}

import 'dart:async';
import 'package:sasMovie/api/core/APIConstants.dart';
import 'package:sasMovie/api/core/APIManager.dart';
import 'package:sasMovie/models/movieModel.dart';
import 'package:sasMovie/models/tmdbResponse.dart';

class RecommendRequest {
  APIManager _apiManager = APIManager();

  Future<List<MovieModel>> fetchRecommendList() async {
    final response = await _apiManager.get(method: APIConstants.Recommend);
    return TmdbResponse.fromJson(response).results;
  }
}

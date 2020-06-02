import 'dart:async';
import 'package:sasMovie/api/core/APIConstants.dart';
import 'package:sasMovie/api/core/APIManager.dart';
import 'package:sasMovie/models/MovieCreditModel.dart';

class CreditsRequest {
  APIManager _apiManager = APIManager();

  Future<MovieCreditModel> fetchCredits(int movieId) async {
    final response = await _apiManager.get(
        method: movieId.toString() + APIConstants.Credits);
    return MovieCreditModel.fromJson(response);
  }
}

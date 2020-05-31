import 'package:sasMovie/models/movieModel.dart';

class TmdbResponse {
  int page;
  int totalResults;
  int totalPages;
  List<MovieModel> results;

  List<MovieModel> get getResults {
    return results;
  }

  TmdbResponse({this.page, this.totalResults, this.totalPages, this.results});

  TmdbResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = new List<MovieModel>();
      json['results'].forEach((v) {
        results.add(new MovieModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
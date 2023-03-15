// To parse this JSON data, do
//
//     final populaMoviesResponse = populaMoviesResponseFromMap(jsonString);

import 'dart:convert';

import 'package:movie_app/models/models.dart';

class PopulaMoviesResponse {
  PopulaMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory PopulaMoviesResponse.fromJson(String str) =>
      PopulaMoviesResponse.fromMap(json.decode(str));

  factory PopulaMoviesResponse.fromMap(Map<String, dynamic> json) =>
      PopulaMoviesResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

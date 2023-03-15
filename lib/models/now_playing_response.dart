import 'dart:convert';

import 'package:movie_app/models/models.dart';

class MoviesResponse {
  MoviesResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates dates;
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory MoviesResponse.fromJson(String str) =>
      MoviesResponse.fromMap(json.decode(str));

  factory MoviesResponse.fromMap(Map<String, dynamic> json) => MoviesResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime maximum;
  final DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

// To parse this JSON data, do
//
//     final polularResponse = polularResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas/models/models.dart';

class PolularResponse {
    PolularResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory PolularResponse.fromJson(String str) => PolularResponse.fromMap(json.decode(str));

    factory PolularResponse.fromMap(Map<String, dynamic> json) => PolularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );
    
}


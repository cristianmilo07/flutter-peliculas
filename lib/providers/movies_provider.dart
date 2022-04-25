import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  
  String _apiKey = '9179d22c154ab0bba3203f7f5e36b6ee';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-Es';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1]) async {
    var url = Uri.https(this._baseUrl, endpoint, {
     'api_key': _apiKey,
     'language': _language,
     'page': '$page'
    });
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
  
  final jsonData = await this._getJsonData('3/movie/now_playing');
  final NowPlayingResponse = PolularResponse.fromJson(jsonData);

  onDisplayMovies = NowPlayingResponse.results;
  notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PolularResponse.fromJson(jsonData);
    //print(nowPlayingResponse.results[0].title);

    this.popularMovies = [...popularMovies, ...popularResponse.results];

    notifyListeners();
  }
}
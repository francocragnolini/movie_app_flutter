import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  //?queries from TMDB api
  final String _apiKey = '45cc44f404ab7f8fb7f7a2081eeabf57';
  final String _baseUrl = "api.themoviedb.org";
  final String _language = 'es-Es';

  //? para adherir los datos de la llamada async de los dos metodos
  //? deberian ser futures e inyectarse en el provider desde el uso de casos
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  //? constructor: inicializa estas dos funciones al comienzo de la aplicacion
  //? ya que la propiedad lazy del provider esta seteada en false
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  //? metodo con la finalidad de evitar repetecion de codigo en las peticiones http
  //? voy implementar el metodo en getOnDisplayMovies() a modo de ejemplo
  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  //? implementando la funcion _getJsonData
  void getOnDisplayMovies() async {
    final jsonData = await _getJsonData("3/movie/now_playing");

    final moviesResponse = MoviesResponse.fromJson(jsonData);
    // print(moviesResponse.results[0].title);
    onDisplayMovies = moviesResponse.results;
    notifyListeners();
  }

  //? sin implementar la funcion _getJsonData
  void getPopularMovies() async {
    final url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    if (response.statusCode != 200) return log("Error");
    final popularResponse = PopulaMoviesResponse.fromJson(response.body);
    onPopularMovies = [...onPopularMovies, ...popularResponse.results];
    notifyListeners();
  }
}

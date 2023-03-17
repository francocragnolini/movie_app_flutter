import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  //?queries from TMDB api
  final String _apiKey = '45cc44f404ab7f8fb7f7a2081eeabf57';
  final String _baseUrl = "api.themoviedb.org";
  final String _language = 'es-Es';

  //? logica para realizar el infinite scroll
  int _popularPage = 0;

  //? para adherir los datos de la llamada async de los dos metodos
  //? deberian ser futures e inyectarse en el provider desde el uso de casos
  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];

  //? int= movieId List<Cast> = lista de actores
  //? es un mapa con una llave movieId que almacena una lista de actores de esa pelicula
  Map<int, List<Cast>> moviesCast = {};

  //!Stream: implemented in search delegate:
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  //? implementing a streamer to apply debounce technique
  final StreamController<List<Movie>> _suggestionsStreamController =
      StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      _suggestionsStreamController.stream;

  //!Stream

  //? constructor: inicializa estas dos funciones al comienzo de la aplicacion
  //? ya que la propiedad lazy del provider esta seteada en false
  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  //? metodo con la finalidad de evitar repetecion de codigo en las peticiones http
  //? voy implementar el metodo en getOnDisplayMovies() a modo de ejemplo
  //? posibilidad de implementar un try-catch para el manejo de errores
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

  //? ejemplo implementado _getJsonData
  void getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular');

    final popularResponse = PopulaMoviesResponse.fromJson(jsonData);
    onPopularMovies = [...onPopularMovies, ...popularResponse.results];
    notifyListeners();
  }

  //? sin implementar la funcion _getJsonData
  // void getPopularMovies() async {
  //   final url = Uri.https(_baseUrl, '3/movie/popular', {
  //     'api_key': _apiKey,
  //     'language': _language,
  //     'page': '1',
  //   });

  //   final response = await http.get(url);
  //   if (response.statusCode != 200) return log("Error");
  //   final popularResponse = PopulaMoviesResponse.fromJson(response.body);
  //   onPopularMovies = [...onPopularMovies, ...popularResponse.results];
  //   notifyListeners();
  // }

  //! ver cast actors
  // getMovieCast(int movieId) async {
  //   //todo: revisar el mapa
  //   print("pidiendo info al servidor - Cast");
  //   final jsonData = await _getJsonData('3/movie/$movieId/credits');
  //   final creditResponse = CreditResponse.fromJson(jsonData);
  //   moviesCast[movieId] = creditResponse.cast;
  // }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      log("tenemos valor a buscar: $value");
      final results = await searchMovie(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) {
        debouncer.value = searchTerm;
      },
    );

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  //? cambia la palabra en el buscador
  @override
  String? get searchFieldLabel => "Buscar";

  //? las acciones a realizar
  //? en este caso borrar busqueda
  //? IconButton "X" en el UI
  //? function: borrar el input
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  //? para redirigir a otra pantalla
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  //? query viene del SearchDelegate por eso tenemos acceso

  @override
  Widget buildResults(BuildContext context) {
    return const Text("buildResults");
  }

  Widget _emptyContainer() {
    return Container(
      child: const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 100,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    moviesProvider.getSuggestionsByQuery(query);

    // return Text("buildSuggetions: $query");
    if (query.isEmpty) {
      return _emptyContainer();
    }
    //! utilizando un stream
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data;

        return ListView.builder(
          itemCount: movies!.length,
          itemBuilder: (BuildContext context, int index) {
            return _MovieItem(movie: movies[index]);
          },
        );
      },
    );

    //! previamente al utilizar el stream, utilizo un future.builder
    // return FutureBuilder(
    //   future: moviesProvider.searchMovie(query),
    //   builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
    //     if (!snapshot.hasData) return _emptyContainer();

    //     final movies = snapshot.data;

    //     return ListView.builder(
    //       itemCount: movies!.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return _MovieItem(movie: movies[index]);
    //       },
    //     );
    //   },
    // );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
      ),
      onTap: () {
        log(movie.title);
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}

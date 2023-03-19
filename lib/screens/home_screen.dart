import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies_provider.dart';
import 'package:movie_app/search/search_delegate.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    log('HomeScreen: ${moviesProvider.onDisplayMovies}');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cinema Movies"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Todo: Card Swipper
            CardSwiper(
              movies: moviesProvider.onDisplayMovies,
            ),

            //Todo: Listado horizontal de peliculas
            MovieSlider(
              movies: moviesProvider.onPopularMovies,
              title: "Populares",
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
    );
  }
}

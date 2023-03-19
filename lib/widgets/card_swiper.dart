import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

//! Lista Usando Libreria de terceros

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key, required this.movies});
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    //! si lista esta vacia, retorna el loading indicator
    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: const CircularProgressIndicator(),
      );
    }

    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      height: size.height * 0.4, //? 50% del height del dispositivo
      // color: Colors.red,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemHeight: size.height * 0.4,
        itemWidth: size.width * 0.6,
        itemBuilder: (context, index) {
          final movie = movies[index];
          log(" CardSwipper: ${movie.posterPath}");
          //? Modelo Movie: creacion de un getter para obtener el fullpath de la imagen
          log(" CardSwipper: ${movie.fullPosterImg}");
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "details", arguments: movie);
              log(movie.title);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

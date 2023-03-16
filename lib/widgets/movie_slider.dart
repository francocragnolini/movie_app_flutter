import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

//! segundo componente del home
//? Convertirlo en un stateful widget para poder aplicar
//?
class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {super.key, required this.movies, this.title, required this.onNextPage});
  final List<Movie> movies;
  final String? title;
  //? pasar una funcion para hacer el infinity scroll
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      log('${scrollController.position.pixels}');
      //? determina la posicion final del scroll
      log('${scrollController.position.maxScrollExtent}');
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        //Todo: llamar provider para ejecutar nuevamente el metodo getpopulars(tiene un incremental de paginas)
        log("Obtener siguiente pagina");
        widget.onNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      // color: Colors.red,
      child: Column(
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, index) => _MoviePoster(
                movie: widget.movies[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//? la imagen del slider
class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, "details",
                arguments: "movie-instance"),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

//! codigo de referncia
// class MovieSlider extends StatelessWidget {
//   const MovieSlider({super.key, required this.movies, this.title});
//   final List<Movie> movies;
//   final String? title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 280,
//       // color: Colors.red,
//       child: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               "Populares",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 20,
//               itemBuilder: (_, index) => _MoviePoster(),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //? la imagen del slider
// class _MoviePoster extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 130,
//       height: 190,
//       // color: Colors.green,
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, "details",
//                 arguments: "movie-instance"),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: const FadeInImage(
//                 placeholder: AssetImage("assets/no-image.jpg"),
//                 image: NetworkImage('https://via.placeholder.com/300x400.png'),
//                 width: 130,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const Text(
//             "Stars War: el retorno del nuevo jedi, de los planetas del exterior",
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

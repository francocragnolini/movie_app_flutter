import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({super.key, required this.movies, this.title});
  final List<Movie> movies;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      // color: Colors.red,
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, index) => _MoviePoster(
                movie: movies[index],
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

//! segundo bloque slider component
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

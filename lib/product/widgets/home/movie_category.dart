import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie_model.dart';
import 'package:netflix_clone/product/widgets/movie_card.dart';

/// Movie Category Widget
class MovieCategory extends StatelessWidget {
  const MovieCategory({required this.title, required this.movies, super.key});
  final String title;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(movie: movie);
            },
          ),
        ),
      ],
    );
  }
}

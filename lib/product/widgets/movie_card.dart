import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie_model.dart';
import 'package:netflix_clone/view/home/movie_detail_view.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, this.withPad = true, super.key});
  final MovieModel movie;
  final bool withPad;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<Widget>(
          builder: (context) => MovieDetailView(
            movie: movie,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: CachedNetworkImage(
            imageUrl: movie.posterImage,
            width: 120,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey.withOpacity(.1)),
            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

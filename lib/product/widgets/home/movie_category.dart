import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie.dart';

/// Movie Category Widget
class MovieCategory extends StatelessWidget {
  const MovieCategory({required this.title, required this.movies, super.key});
  final String title;
  final List<Movie> movies;

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
              return Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: CachedNetworkImage(
                    imageUrl: movies[index].posterUrl,
                    width: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey.withOpacity(.1)),
                    errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

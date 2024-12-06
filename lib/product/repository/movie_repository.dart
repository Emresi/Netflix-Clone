// import 'dart:convert';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:netflix_clone/product/models/movie.dart';

// final class MovieRepository {
//   MovieRepository._();

//   static final MovieRepository _instance = MovieRepository._();

//   static MovieRepository get instance => _instance;

//   List<Movie> _movies = [];

//   Future<void> loadMovies() async {
//     // final start = DateTime.now();
//     try{_movies = await loadMoviesFromAssets();} catch(e){print(e.toString());}
//     // final end = DateTime.now();
//     // print('It took ${end.difference(start).inMilliseconds} to init the ${_movies.length} films');
//   }

//   List<Movie> sortByMostPopular({int limit = 33}) {
//     final sortedMovies = _movies..sort((a, b) => b.popularity.compareTo(a.popularity));
//     return sortedMovies.take(limit).toList();
//   }

//   List<Movie> sortByBestRatings({int limit = 33}) {
//     final sortedMovies = _movies..sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
//     return sortedMovies.take(limit).toList();
//   }

//   List<Movie> filterByGenre(String genre, {int limit = 33}) {
//     return _movies.where((movie) => movie.genre.split(', ').contains(genre)).take(limit).toList();
//   }

//   List<Movie> get movies => _movies;
// }

// Future<List<Movie>> loadMoviesFromAssets() async {
//   try {
//     final jsonString = await rootBundle.loadString('assets/json/movies.json');
//     final jsonData = json.decode(jsonString) as List<dynamic>;
//     return jsonData.map((item) {
//       if (item is Map<String, dynamic>) {
//         return Movie.fromJson(item);
//       } else {
//         throw const FormatException('Invalid data format in the movie list');
//       }
//     }).toList();
//   } catch (e) {
//     debugPrint('Error loading movies from assets: $e');
//     return [];
//   }
// }

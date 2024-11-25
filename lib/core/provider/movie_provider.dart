import 'package:flutter/material.dart';
import 'package:netflix_clone/product/enums/categories.dart';
import 'package:netflix_clone/product/models/movie.dart';
import 'package:netflix_clone/product/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  late List<Movie> trendingMovies;
  late List<Movie> topRatedMovies;
  late Map<String, List<Movie>> categoryLists;
  bool isLoading = true;

  Future<void> loadMovies() async {
    final repo = MovieRepository.instance;
    await repo.loadMovies();
    trendingMovies = repo.sortByMostPopular();
    topRatedMovies = repo.sortByBestRatings();
    categoryLists = {
      for (final genre in Genres.values) genre.turkish: repo.filterByGenre(genre.english),
    };
    isLoading = false;
    notifyListeners();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie_model.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeProvider extends ChangeNotifier {
  late List<MovieModel> trendingMovies;
  late List<MovieModel> popularMovies;
  Map<String, List<MovieModel>> categoryLists = {};
  late PaletteGenerator paletteGenerator;
  String? selectedText;
  bool isLoading = true;
  double opacity = 1;

  void selectText(String text) {
    selectedText = text;
    notifyListeners();
  }

  LinearGradient? get backGroundGradient => LinearGradient(
        colors: [
          paletteGenerator.dominantColor?.color.withOpacity(opacity) ?? Colors.black.withOpacity(0.1),
          paletteGenerator.vibrantColor?.color.withOpacity(opacity) ?? Colors.black,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  void filterByGenre() {
    // Generate a list of genre IDs from 0 to 99
    final genreIds = List.generate(100, (index) => index);

    // Clear the previous category list
    categoryLists.clear();

    // Organize movies by genre
    for (final genreId in genreIds) {
      final filteredMovies = trendingMovies.where((movie) {
        return movie.genreIds.contains(genreId);
      }).toList();

      if (filteredMovies.isNotEmpty) {
        categoryLists[genreId.toString()] = filteredMovies;
      }
    }
  }

  Future<void> loadMovies() async {
    trendingMovies = await MovieModel.fetchTrendingMovies();
    popularMovies = await MovieModel.fetchPopularMovies();
    if (trendingMovies.isNotEmpty) {
      final details = await trendingMovies[0].fetchMediaDetails();
      print(details.toJson());
    }
    filterByGenre();
    await _generatePalette();
  }

  Future<void> _generatePalette() async {
    final imageProvider = CachedNetworkImageProvider(trendingMovies.first.posterImage);
    final palette = await PaletteGenerator.fromImageProvider(imageProvider);
    paletteGenerator = palette;
    isLoading = false;
    notifyListeners();
  }

  void setOpacity(double offset) {
    opacity = (1.0 - (offset / 100)).clamp(0.0, 1.0);
  }
}

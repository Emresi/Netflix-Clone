import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie_model.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeProvider extends ChangeNotifier {
  late List<MovieModel> trendingMovies;
  List<MovieModel> popularMovies = [];
  Map<String, List<MovieModel>> categoryLists = {};
  late PaletteGenerator paletteGenerator;
  Map<int, String> genreMap = {};
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

  void filterByGenre(List<MovieModel> movies) {
    categoryLists.clear();
    for (final genreId in genreMap.keys) {
      final filteredMovies = movies.where((movie) {
        return movie.genreIds.contains(genreId);
      }).toList();
      if (filteredMovies.isNotEmpty) {
        categoryLists[genreMap[genreId]!] = filteredMovies;
      }
    }
  }

  Future<void> initHomePage() async {
    isLoading = true;
    genreMap = await MovieModel.fetchGenresV2();
    trendingMovies = await MovieModel.fetchTrendingMovies();
    for (var i = 1; i < 6; i++) {
      final popularOnes = await MovieModel.fetchPopularMovies(page: i);
      popularMovies.addAll(popularOnes);
    }
    filterByGenre(popularMovies);
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

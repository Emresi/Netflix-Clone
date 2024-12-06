import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/core/global/global.dart';
import 'package:netflix_clone/product/keys/api_key.dart';
import 'package:netflix_clone/product/models/movie_model.dart';

/// Fetches and tests the details of a movie by query
// Future<void> testMovieDetails(String query) async {
//   // Step 1: Search for the movie by query
//   final searchUrl = '$baseUrl/search/movie?api_key=$apiKey&language=en-US&query=${Uri.encodeComponent(query)}';
//   final searchResponse = await http.get(Uri.parse(searchUrl));
//   if (searchResponse.statusCode != 200) {
//     print('Error searching for movie: ${searchResponse.body}');
//     return;
//   }
//   final searchResults = jsonDecode(searchResponse.body) as Map<String, dynamic>;
//   final movies = searchResults['results'] as List<dynamic>?;

//   if (movies == null || movies.isEmpty) {
//     print('No movies found for query: $query');
//     return;
//   }

//   // Use the first movie result for testing
//   final movieData = movies.first as Map<String, dynamic>?;
//   if (movieData == null) return;
//   final movie = MovieModel.fromJson(movieData);
//   print(movie.id);
//   // Step 2: Fetch additional details
//   print('Title: ${movie.title}');
//   print('Release Year: ${movie.releaseYear}');
//   print('Overview: ${movie.overview}');

//   final certification = await movie.fetchCertification();
//   print('Certification: ${certification ?? "N/A"}');

//   final runtime = await movie.fetchRuntime();
//   print('Runtime: ${runtime != null ? "$runtime minutes" : "N/A"}');

//   final genres = await movie.fetchGenres();
//   print('Genres: ${genres.isNotEmpty ? genres.join(", ") : "N/A"}');

//   final credits = await movie.fetchCredits();
//   print('Actors: ${credits["actors"]!.isNotEmpty ? credits["actors"]?.join(", ") : "N/A"}');
//   print('Directors: ${credits["directors"]!.isNotEmpty ? credits["directors"]?.join(", ") : "N/A"}');
//   print('Scenarists: ${credits["scenarists"]!.isNotEmpty ? credits["scenarists"]?.join(", ") : "N/A"}');

//   final trailerUrl = await movie.fetchOfficialTrailer();
//   print('Trailer: ${trailerUrl ?? "N/A"}');
// }

// Future<void> testMovieDetailsById(int movieId) async {
//   // Step 1: Fetch movie details by ID
//   final movieDetailsUrl = '$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US';
//   final movieDetailsResponse = await http.get(Uri.parse(movieDetailsUrl));

//   if (movieDetailsResponse.statusCode != 200) {
//     print('Error fetching movie details: ${movieDetailsResponse.body}');
//     return;
//   }

//   final movieData = jsonDecode(movieDetailsResponse.body) as Map<String, dynamic>;
//   final movie = MovieModel.fromJson(movieData);

//   print('Title: ${movie.title}');
//   print('Release Year: ${movie.releaseYear}');
//   print('Overview: ${movie.overview}');

//   // Step 2: Fetch additional details
//   final certification = await movie.fetchCertification();
//   print('Certification: ${certification ?? "N/A"}');

//   final runtime = await movie.fetchRuntime();
//   print('Runtime: ${runtime != null ? "$runtime minutes" : "N/A"}');

//   final genres = await movie.fetchGenres();
//   print('Genres: ${genres.isNotEmpty ? genres.join(", ") : "N/A"}');

//   final credits = await movie.fetchCredits();
//   print('Actors: ${credits["actors"]!.isNotEmpty ? credits["actors"]?.join(", ") : "N/A"}');
//   print('Directors: ${credits["directors"]!.isNotEmpty ? credits["directors"]?.join(", ") : "N/A"}');
//   print('Scenarists: ${credits["scenarists"]!.isNotEmpty ? credits["scenarists"]?.join(", ") : "N/A"}');

//   final trailerUrl = await movie.fetchOfficialTrailer();
//   print('Trailer: ${trailerUrl ?? "N/A"}');
// }

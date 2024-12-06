import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:netflix_clone/core/global/global.dart';
import 'package:netflix_clone/product/keys/api_key.dart';
import 'package:netflix_clone/product/models/media_detail.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  MovieModel({
    required this.adult,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    this.backdropPath,
    this.mediaDetail,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  final int id;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  final MediaDetail? mediaDetail;

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  String get releaseYear => releaseDate.split('-').first;

  String get posterImage => 'https://image.tmdb.org/t/p/w500$posterPath';

  static Future<List<MovieModel>> fetchTopRatedMovies({int page = 1}) async {
    final topRatedMoviesUrl = '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-US&page=$page';

    try {
      final response = await http.get(Uri.parse(topRatedMoviesUrl));
      if (response.statusCode != 200) {
        print('Error fetching top-rated movies: ${response.body}');
        return [];
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results.map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching top-rated movies: $e');
      return [];
    }
  }

  static Future<List<MovieModel>> fetchPopularMovies() async {
    const popularMoviesUrl = '$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1';

    try {
      final response = await http.get(Uri.parse(popularMoviesUrl));
      if (response.statusCode != 200) {
        print('Error fetching popular movies ${response.statusCode}: ${response.body}');
        return [];
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;
      print(results);
      return results.map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching popular movies: $e');
      return [];
    }
  }

  /// Fetches a list of trending movies from the API
  static Future<List<MovieModel>> fetchTrendingMovies({String timeWindow = 'day'}) async {
    final trendingMoviesUrl = '$baseUrl/trending/movie/$timeWindow?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(trendingMoviesUrl));
      if (response.statusCode != 200) {
        print('Error fetching trending movies: ${response.body}');
        return [];
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results.map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching trending movies: $e');
      return [];
    }
  }

  Future<String?> fetchCertification() async {
    final certificationsLink = '$baseUrl/movie/$id/release_dates?api_key=$apiKey';
    final response = await http.get(Uri.parse(certificationsLink));

    if (response.statusCode != 200) {
      print('Error fetching certifications: ${response.body}');
      return null;
    }

    final result = jsonDecode(response.body) as Map<String, dynamic>;
    final results = (result['results'] as List<dynamic>)
        .map((item) {
          if (item is Map<String, dynamic>) {
            return item;
          }
          return null;
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    final usCertification = results.firstWhere(
      (item) => item['iso_3166_1'] == 'US',
      orElse: () => {},
    );

    if (usCertification.isEmpty) return null;

    final releaseDates = (usCertification['release_dates'] as List<dynamic>)
        .map((item) {
          if (item is Map<String, dynamic>) {
            return item;
          }
          return null;
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    final certification = releaseDates.firstWhere(
      (item) => item['certification'] != null,
      orElse: () => {},
    );

    return certification.isEmpty ? null : certification['certification'] as String;
  }

  Future<Map<String, dynamic>> fetchDetails() async {
    final url = '$baseUrl/movie/$id?api_key=$apiKey&language=en-US';
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<int?> fetchRuntime() async {
    final details = await fetchDetails();
    return details['runtime'] as int?;
  }

  Future<List<String>> fetchGenres() async {
    final details = await fetchDetails();
    final genres = details['genres'] as List<dynamic>?;
    return genres?.map((genre) => genre['name'] as String).toList() ?? [];
  }

  // Future<Map<String, List<String>>> fetchCredits() async {
  //   final creditsLink = '$baseUrl/movie/$id/credits?api_key=$apiKey&language=en-US';
  //   final response = await http.get(Uri.parse(creditsLink));
  //   if (response.statusCode != 200) {
  //     print('Error fetching credits: ${response.body}');
  //     return {};
  //   }
  //   final result = jsonDecode(response.body) as Map<String, dynamic>;
  //   final castList = (result['cast'] as List<dynamic>)
  //       .map((item) {
  //         if (item is Map<String, dynamic>) {
  //           return item;
  //         }
  //         return null;
  //       })
  //       .whereType<Map<String, dynamic>>()
  //       .toList();
  //   final crewList = (result['crew'] as List<dynamic>)
  //       .map((item) {
  //         if (item is Map<String, dynamic>) {
  //           return item;
  //         }
  //         return null;
  //       })
  //       .whereType<Map<String, dynamic>>()
  //       .toList();
  //   final actors = castList.map((item) => item['name'] as String).take(10).toList();
  //   final directors =
  //       crewList.where((item) => item['job'] == 'Director').map((item) => item['name'] as String).toList();
  //   final scenarists =
  //       crewList.where((item) => item['job'] == 'Screenplay').map((item) => item['name'] as String).toList();
  //   return {
  //     'actors': actors,
  //     'directors': directors,
  //     'scenarists': scenarists,
  //   };
  // }

  // Future<String?> fetchOfficialTrailer() async {
  //   final videosLink = '$baseUrl/movie/$id/videos?api_key=$apiKey&language=en-US';
  //   final result =
  //       await http.get(Uri.parse(videosLink)).then((response) => jsonDecode(response.body) as Map<String, dynamic>?);
  //   if (result == null || result['results'] == null) return null;
  //   final videoResults = (result['results'] as List<dynamic>).map((item) => item as Map<String, dynamic>).toList();
  //   final item = videoResults.firstWhere(
  //     (item) => item['name'] == 'Official Trailer' && item['site'] == 'YouTube',
  //     orElse: () => {},
  //   );
  //   if (item.isEmpty) return null;
  //   return 'https://www.youtube.com/watch?v=${item['key']}';
  // }

  Future<Map<int, String>> fetchGenresV2() async {
    const url = '$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('Error fetching genres: ${response.body}');
      return {};
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final genres = (data['genres'] as List<dynamic>?)
        ?.map((genre) => genre as Map<String, dynamic>)
        .where((genre) => genre.containsKey('id') && genre.containsKey('name'))
        .toList();

    if (genres == null) return {};

    return {
      for (final genre in genres) genre['id'] as int: genre['name'] as String,
    };
  }

  Future<MediaDetail> fetchMediaDetails() async {
    final detailsUrl = '$baseUrl/movie/$id?api_key=$apiKey&language=en-US';
    final certificationsUrl = '$baseUrl/movie/$id/release_dates?api_key=$apiKey';
    final creditsUrl = '$baseUrl/movie/$id/credits?api_key=$apiKey&language=en-US';

    try {
      // Fetch details, certifications, and credits concurrently
      final responses = await Future.wait([
        http.get(Uri.parse(detailsUrl)),
        http.get(Uri.parse(certificationsUrl)),
        http.get(Uri.parse(creditsUrl)),
      ]);

      // Fetch genres separately
      final genreMap = await fetchGenresV2();

      final detailsResponse = responses[0];
      final certificationsResponse = responses[1];
      final creditsResponse = responses[2];

      if (detailsResponse.statusCode != 200 ||
          certificationsResponse.statusCode != 200 ||
          creditsResponse.statusCode != 200) {
        throw Exception('Error fetching media details');
      }

      // Parse responses
      final detailsData = jsonDecode(detailsResponse.body) as Map<String, dynamic>;
      final certificationsData = jsonDecode(certificationsResponse.body) as Map<String, dynamic>;
      final creditsData = jsonDecode(creditsResponse.body) as Map<String, dynamic>;

      // Extract data
      final title = detailsData['title'] as String?;
      final overview = detailsData['overview'] as String?;
      final genreIds = (detailsData['genres'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((genre) => genre['id'] as int)
          .toList();

      final genres = genreIds?.map((id) => genreMap[id] ?? 'Unknown').toList();

      // Extract certification
      String? certification;
      final results = certificationsData['results'] as List<dynamic>?;
      final usCertifications =
          results?.whereType<Map<String, dynamic>>().firstWhere((item) => item['iso_3166_1'] == 'US', orElse: () => {});
      if (usCertifications != null && usCertifications.isNotEmpty) {
        final releaseDates = usCertifications['release_dates'] as List<dynamic>?;
        final certificationData = releaseDates
            ?.whereType<Map<String, dynamic>>()
            .firstWhere((item) => item['certification'] != null, orElse: () => {});
        certification = certificationData?['certification'] as String?;
      }

      // Extract credits
      final castList = (creditsData['cast'] as List<dynamic>?)?.whereType<Map<String, dynamic>>().toList();
      final crewList = (creditsData['crew'] as List<dynamic>?)?.whereType<Map<String, dynamic>>().toList();

      final actors = castList?.map((item) => item['name'] as String).take(10).toList() ?? [];
      final directors =
          crewList?.where((item) => item['job'] == 'Director').map((item) => item['name'] as String).toList() ?? [];
      final scenarists =
          crewList?.where((item) => item['job'] == 'Screenplay').map((item) => item['name'] as String).toList() ?? [];

      return MediaDetail(
        title: title ?? 'Unknown Title',
        overview: overview ?? 'No Overview Available',
        certification: certification ?? 'Unrated',
        genres: genres ?? [],
        actors: actors,
        directors: directors,
        scenarists: scenarists,
      );
    } catch (e) {
      print('Error fetching media details: $e');
      rethrow;
    }
  }
}




/// details :
/// certification 
/// overview
/// title
/// actors
/// manager 
/// scenarist
/// gender 
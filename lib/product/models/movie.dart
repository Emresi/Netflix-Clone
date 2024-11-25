import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart'; // Generated file

/// A model representing a movie, including its details such as title, release date,
/// popularity, and more.
@JsonSerializable()
class Movie {
  /// Creates a new instance of the `Movie` class.
  ///
  /// All parameters are required to ensure that a `Movie` object is properly initialized.
  Movie({
    required this.releaseDate,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
    required this.originalLanguage,
    required this.genre,
    required this.posterUrl,
  });

  /// Creates a `Movie` object from a JSON map.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// The release date of the movie in the format `YYYY-MM-DD`.
  @JsonKey(name: 'Release_Date')
  final String releaseDate;

  /// The title of the movie.
  @JsonKey(name: 'Title')
  final String title;

  /// A brief overview or description of the movie's plot.
  @JsonKey(name: 'Overview')
  final String overview;

  /// The popularity score of the movie, reflecting its trending status.
  @JsonKey(name: 'Popularity')
  final double popularity;

  /// The number of votes the movie has received.
  @JsonKey(name: 'Vote_Count')
  final int voteCount;

  /// The average rating of the movie based on user votes, ranging from 0.0 to 10.0.
  @JsonKey(name: 'Vote_Average')
  final double voteAverage;

  /// The original language of the movie (e.g., "en" for English).
  @JsonKey(name: 'Original_Language')
  final String originalLanguage;

  /// The genres associated with the movie, represented as a comma-separated string.
  @JsonKey(name: 'Genre')
  final String genre;

  /// The URL of the movie's poster image.
  @JsonKey(name: 'Poster_Url')
  final String posterUrl;

  /// Converts a `Movie` object into a JSON map.
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

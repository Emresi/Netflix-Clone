import 'package:json_annotation/json_annotation.dart';

part 'tv_model.g.dart';

@JsonSerializable()
class TVModel {
  TVModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  final int id;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_name')
  final String originalName;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'first_air_date')
  final String firstAirDate;
  final String name;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  // Factory method for deserialization
  factory TVModel.fromJson(Map<String, dynamic> json) => _$TVModelFromJson(json);

  // Method for serialization
  Map<String, dynamic> toJson() => _$TVModelToJson(this);
}

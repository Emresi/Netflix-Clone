// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      releaseDate: json['Release_Date'] as String,
      title: json['Title'] as String,
      overview: json['Overview'] as String,
      popularity: (json['Popularity'] as num).toDouble(),
      voteCount: (json['Vote_Count'] as num).toInt(),
      voteAverage: (json['Vote_Average'] as num).toDouble(),
      originalLanguage: json['Original_Language'] as String,
      genre: json['Genre'] as String,
      posterUrl: json['Poster_Url'] as String,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'Release_Date': instance.releaseDate,
      'Title': instance.title,
      'Overview': instance.overview,
      'Popularity': instance.popularity,
      'Vote_Count': instance.voteCount,
      'Vote_Average': instance.voteAverage,
      'Original_Language': instance.originalLanguage,
      'Genre': instance.genre,
      'Poster_Url': instance.posterUrl,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaDetail _$MediaDetailFromJson(Map<String, dynamic> json) => MediaDetail(
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      actors:
          (json['actors'] as List<dynamic>).map((e) => e as String).toList(),
      directors:
          (json['directors'] as List<dynamic>).map((e) => e as String).toList(),
      scenarists: (json['scenarists'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      runTime: (json['runTime'] as num?)?.toInt(),
      trailer: json['trailer'] as String?,
      otherVideos: (json['otherVideos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      certification: json['certification'] as String?,
      overview: json['overview'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$MediaDetailToJson(MediaDetail instance) =>
    <String, dynamic>{
      'certification': instance.certification,
      'overview': instance.overview,
      'title': instance.title,
      'runTime': instance.runTime,
      'trailer': instance.trailer,
      'otherVideos': instance.otherVideos,
      'genres': instance.genres,
      'actors': instance.actors,
      'directors': instance.directors,
      'scenarists': instance.scenarists,
    };

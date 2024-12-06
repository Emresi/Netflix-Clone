import 'package:json_annotation/json_annotation.dart';

part 'media_detail.g.dart';

@JsonSerializable()
class MediaDetail {
  MediaDetail({
    required this.genres,
    required this.actors,
    required this.directors,
    required this.scenarists,
    this.certification,
    this.overview,
    this.title,
  });

  factory MediaDetail.fromJson(Map<String, dynamic> json) => _$MediaDetailFromJson(json);
  final String? certification;
  final String? overview;
  final String? title;
  final List<String> genres;
  final List<String> actors;
  final List<String> directors;
  final List<String> scenarists;

  Map<String, dynamic> toJson() => _$MediaDetailToJson(this);
}

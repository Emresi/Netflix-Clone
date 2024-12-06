import 'package:flutter/material.dart';
import 'package:netflix_clone/product/enums/media_enums.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({this.mediaType, super.key});
  final MediaType? mediaType;
  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

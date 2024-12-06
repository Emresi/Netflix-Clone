import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/enums/categories.dart';
import 'package:netflix_clone/product/models/movie_model.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({required this.featuredMovie, super.key});
  final MovieModel featuredMovie;

  @override
  HeroSectionState createState() => HeroSectionState();
}

class HeroSectionState extends State<HeroSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(3));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: CachedNetworkImage(
              imageUrl: widget.featuredMovie.posterImage,
              width: double.infinity,
              height: 500,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.transparent),
              errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.featuredMovie.title,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const _CategoryTextList(
                  genre: '',
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: buttonShape,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.play_arrow, color: Colors.black),
                            SizedBox(width: 5),
                            Text('Oynat', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 33),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.withOpacity(0.7),
                          shape: buttonShape,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add_rounded, color: Colors.white),
                            SizedBox(width: 5),
                            Text('Listem', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTextList extends StatelessWidget {
  const _CategoryTextList({
    required this.genre,
  });
  final String genre;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _buildTextSpans(),
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  List<TextSpan> _buildTextSpans() {
    final categoryTexts = genre.categoryTexts;

    final spans = <TextSpan>[];
    for (var i = 0; i < categoryTexts.length; i++) {
      spans
        ..add(
          const TextSpan(
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
        ..add(TextSpan(text: categoryTexts[i]));

      if (i < categoryTexts.length - 1) {
        spans.add(
          const TextSpan(
            text: ' ● ',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        );
      }
    }
    return spans;
  }
}

extension _GenreExtension on String {
  List<String> get categoryTexts {
    return Genres.values
        .where((genre) => contains(genre.english))
        .map((genre) => genre.turkish.split(' ').first)
        .toList();
  }
}

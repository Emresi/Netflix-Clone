import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/models/movie.dart';
import 'package:palette_generator/palette_generator.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({required this.featuredMovie, super.key});
  final Movie featuredMovie;

  @override
  HeroSectionState createState() => HeroSectionState();
}

class HeroSectionState extends State<HeroSection> {
  PaletteGenerator? _paletteGenerator;

  @override
  void initState() {
    super.initState();
    _generatePalette();
  }

  Future<void> _generatePalette() async {
    final imageProvider = CachedNetworkImageProvider(widget.featuredMovie.posterUrl);
    final palette = await PaletteGenerator.fromImageProvider(imageProvider);
    setState(() {
      _paletteGenerator = palette;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _paletteGenerator?.dominantColor?.color ?? Colors.black.withOpacity(0.1),
            _paletteGenerator?.vibrantColor?.color ?? Colors.black,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          //extract
          borderRadius: BorderRadius.circular(13),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: CachedNetworkImage(
                imageUrl: widget.featuredMovie.posterUrl,
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: Colors.transparent),
                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.featuredMovie.title,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        child: const Row(
                          children: [
                            Icon(Icons.play_arrow, color: Colors.black),
                            SizedBox(width: 5),
                            Text('Play', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.withOpacity(0.7)),
                        child: const Row(
                          children: [
                            Icon(Icons.info, color: Colors.white),
                            SizedBox(width: 5),
                            Text('More Info', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

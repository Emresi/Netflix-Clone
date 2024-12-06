import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/enums/media_enums.dart';
import 'package:netflix_clone/product/models/media_detail.dart';
import 'package:netflix_clone/product/models/movie_model.dart';
import 'package:netflix_clone/product/widgets/home/action_buttons.dart';
import 'package:netflix_clone/product/widgets/movie_card.dart';
import 'package:netflix_clone/product/widgets/sized_20.dart';
import 'package:netflix_clone/view/home/video_view.dart';

class MovieDetailView extends StatefulWidget {
  const MovieDetailView({
    required this.movie,
    this.mediaType = MediaType.movie,
    this.camFromSearch = false,
    super.key,
  });
  final MediaType mediaType;
  final bool camFromSearch;
  final MovieModel movie;
  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  MediaDetail? mediaDetail;
  bool isLoading = true;
  int pageIndex = 0;
  void changeLoading() {
    if (mounted) {
      setState(() => isLoading = !isLoading);
    }
  }

  List<MovieModel> similarMovies = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (widget.mediaType == MediaType.movie) {
        mediaDetail = await MovieModel.fetchMediaDetails(id: widget.movie.id);
      }
      similarMovies = await widget.movie.fetchSimilarMovies() ?? [];
      print(similarMovies);
      changeLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final isTv = widget.mediaType == MediaType.tv;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        actions: const [
          DownloadButton(),
          SearchButton(),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h * .36,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: widget.movie.posterImage,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MovieActionDetails(mediaDetail: mediaDetail, movie: widget.movie),
                        const Sized20(),
                        _MovieActionButton(
                          video: mediaDetail?.trailer,
                        ),
                        const Sized10(),
                        const _MovieActionButton(isPlay: false),
                        const Sized10(),
                        Text(
                          widget.movie.overview,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Sized10(),
                        _FooterDetails(mediaDetail: mediaDetail, title: widget.movie.title),
                      ],
                    ),
                  ),
                  const Sized20(),
                  Column(
                    children: [
                      DefaultTabController(
                        length: isTv ? 2 : 1,
                        child: TabBar(
                          onTap: (value) => setState(() => pageIndex = value),
                          indicatorColor: Colors.red,
                          labelStyle: const TextStyle(color: Colors.white, fontSize: 17),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          tabs: [
                            if (isTv)
                              const Tab(
                                height: 33,
                                text: LocaleKeys.kEpisodes,
                              ),
                            const Tab(
                              height: 33,
                              text: LocaleKeys.kSimilar,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 5),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                          ),
                          itemCount: similarMovies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movie: similarMovies[index],
                              withPad: false,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class _MovieActionDetails extends StatelessWidget {
  const _MovieActionDetails({
    required this.movie,
    required this.mediaDetail,
  });

  final MovieModel movie;
  final MediaDetail? mediaDetail;

  @override
  Widget build(BuildContext context) {
    const pad = SizedBox(width: 10);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: const TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontFamily: LocaleKeys.kFontFam,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              movie.releaseYear,
              style: const TextStyle(fontSize: 13),
            ),
            pad,
            if ((mediaDetail?.certification ?? '').isNotEmpty) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                child: Text(
                  '${mediaDetail?.certification}',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              pad,
            ],
            Text('${mediaDetail?.movDuration}'),
            pad,
            const Icon(
              Icons.hd_outlined,
              color: Colors.white70,
            ),
          ],
        ),
      ],
    );
  }
}

class _MovieActionButton extends StatelessWidget {
  const _MovieActionButton({this.isPlay = true, this.video});
  final bool isPlay;
  final String? video;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isPlay) {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (context) => VideoPlayerPage(
                videoUrl: video!,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloaded')));
        }
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        foregroundColor: isPlay ? Colors.black : Colors.white70,
        backgroundColor: isPlay ? Colors.white : Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Icon(
            isPlay ? Icons.play_arrow_rounded : Icons.file_download_outlined,
            size: 27,
          ),
          const SizedBox(width: 5),
          Text(
            isPlay ? 'Play' : 'Download',
            style: const TextStyle(fontSize: 19),
          ),
        ],
      ),
    );
  }
}

class _MovieCast extends StatelessWidget {
  const _MovieCast({required this.title, required this.crew});
  final String title;
  final List<String> crew;
  @override
  Widget build(BuildContext context) {
    if (crew.isEmpty) return const SizedBox.shrink();
    const style = TextStyle(
      fontSize: 12,
      color: Colors.white70,
    );
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: style.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: crew.join(', '), style: style),
        ],
      ),
    );
  }
}

class _MoreDetailGroup extends StatelessWidget {
  const _MoreDetailGroup({required this.title, required this.crew});
  final String title;
  final List<String>? crew;
  @override
  Widget build(BuildContext context) {
    if (crew == null || crew!.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        for (final item in crew!) ...[
          Text(
            item,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
          const Sized10(),
        ]
      ],
    );
  }
}

class _FooterDetails extends StatelessWidget {
  const _FooterDetails({required this.mediaDetail, required this.title});
  final MediaDetail? mediaDetail;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          enableDrag: false,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox.shrink(),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: Colors.white,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const Sized20(),
                      _MoreDetailGroup(
                        title: LocaleKeys.kActors,
                        crew: mediaDetail?.actors,
                      ),
                      _MoreDetailGroup(
                        title: LocaleKeys.kDirectors,
                        crew: mediaDetail?.directors,
                      ),
                      _MoreDetailGroup(
                        title: LocaleKeys.kScenarists,
                        crew: mediaDetail?.scenarists,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (mediaDetail?.actors != null) _MovieCast(title: LocaleKeys.kActors, crew: mediaDetail!.actors),
          const SizedBox(height: 5),
          if (mediaDetail?.directors != null) _MovieCast(title: LocaleKeys.kDirectors, crew: mediaDetail!.directors),
        ],
      ),
    );
  }
}

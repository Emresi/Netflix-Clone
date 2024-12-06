import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/home_provider.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/enums/media_enums.dart';
import 'package:netflix_clone/product/widgets/home/action_buttons.dart';
import 'package:netflix_clone/product/widgets/home/hero_section.dart';
import 'package:netflix_clone/product/widgets/home/movie_category.dart';

import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    Future.microtask(() async {
      if (!mounted) return;
      await context.read<HomeProvider>().initHomePage();
    });
  }

  void _scrollListener() {
    final offset = _scrollController.offset;
    context.read<HomeProvider>().setOpacity(offset);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) return const LinearProgressIndicator();

          final movieCategories = provider.categoryLists.entries.map((entry) {
            final genreName = entry.key;
            final movies = entry.value;
            return MovieCategory(title: genreName, movies: movies);
          }).toList();
          final isMediaType = MediaType.values.map((e) => e.text).toList().contains(provider.selectedText);
          return Container(
            decoration: BoxDecoration(gradient: provider.backGroundGradient),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Row(
                    children: [
                      if (provider.selectedText == null || isMediaType)
                        ...MediaType.values.map(
                          (type) => _buildChip(
                            child: Text(type.text, style: const TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<Widget>(
                                  builder: (context) => Container(),
                                ),
                              );
                            },
                          ),
                        ),
                      _buildChip(
                        child: Row(
                          children: [
                            Text(
                              !isMediaType ? provider.selectedText ?? ' ' : LocaleKeys.kCategories,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      HeroSection(featuredMovie: provider.trendingMovies.first),
                      const SizedBox(height: 20),
                      MovieCategory(title: LocaleKeys.kPopular, movies: provider.popularMovies),
                      MovieCategory(title: LocaleKeys.kTrends, movies: provider.trendingMovies),
                      ...movieCategories,
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip({
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ActionChip(
        onPressed: onPressed,
        label: child,
        shape: const CircleBorder(side: BorderSide(color: Colors.white)),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Image.asset(
        'assets/images/logo.png',
        height: 30,
      ),
      actions: const [
        DownloadButton(),
        SearchButton(),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

// import 'package:flutter/material.dart';
// import 'package:netflix_clone/core/provider/movie_provider.dart';
// import 'package:netflix_clone/product/constants/locale_keys.dart';
// import 'package:netflix_clone/product/widgets/home/hero_section.dart';
// import 'package:netflix_clone/product/widgets/home/movie_category.dart';
// import 'package:provider/provider.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   late ScrollController _scrollController;
//   double _scrollOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);

//     // Load movies when the view is initialized
//     Future.microtask(() async {
//       if (!mounted) return;
//       await context.read<MovieProvider>().loadMovies();
//     });
//   }

//   void _scrollListener() {
//     setState(() {
//       _scrollOffset = _scrollController.offset;
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Consumer<MovieProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final movieCategories = provider.categoryLists.entries.map((entry) {
//             final genreName = entry.key;
//             final movies = entry.value;
//             return MovieCategory(title: genreName, movies: movies);
//           }).toList();

//           return Stack(
//             children: [
//               // Main Content
//               CustomScrollView(
//                 controller: _scrollController,
//                 slivers: [
//                   // Genre Filter Bar
//                   SliverAppBar(
//                     floating: true,
//                     elevation: 0,
//                     backgroundColor: Colors.black.withOpacity((_scrollOffset / 350).clamp(0, 0.8)),
//                     title: _buildGenreFilters(),
//                   ),
//                   // Content List
//                   SliverList(
//                     delegate: SliverChildListDelegate([
//                       HeroSection(featuredMovie: provider.trendingMovies.first),
//                       const SizedBox(height: 20),
//                       MovieCategory(
//                         title: LocaleKeys.kPopular,
//                         movies: provider.trendingMovies,
//                       ),
//                       MovieCategory(
//                         title: LocaleKeys.kTopRated,
//                         movies: provider.topRatedMovies,
//                       ),
//                       ...movieCategories,
//                     ]),
//                   ),
//                 ],
//               ),
//               // Gradient Overlay
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 height: 200,
//                 child: ShaderMask(
//                   shaderCallback: (Rect bounds) {
//                     return LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity((_scrollOffset / 350).clamp(0, 1)),
//                         Colors.black.withOpacity((_scrollOffset / 350).clamp(0, 0.7)),
//                         Colors.transparent,
//                       ],
//                       stops: const [0.0, 0.5, 1.0],
//                     ).createShader(bounds);
//                   },
//                   blendMode: BlendMode.dstIn,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.red.shade900.withOpacity(0.7),
//                           Colors.red.shade800.withOpacity(0.5),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // App Bar Content
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: PreferredSize(
//                   preferredSize: const Size.fromHeight(56),
//                   child: SafeArea(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Image.asset(
//                             'assets/images/logo.png',
//                             height: 30,
//                           ),
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.file_download_outlined,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.search,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildGenreFilters() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _buildChip('All'),
//           _buildChip('Action'),
//           _buildChip('Comedy'),
//           _buildChip('Horror'),
//           _buildChip('Drama'),
//           _buildChip('Sci-Fi'),
//         ],
//       ),
//     );
//   }

//   Widget _buildChip(String label) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: Chip(
//         label: Text(label),
//         backgroundColor: Colors.grey[800],
//         labelStyle: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

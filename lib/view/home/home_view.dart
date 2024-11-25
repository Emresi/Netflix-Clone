import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/movie_provider.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
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
  double _appBarOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    Future.microtask(() async {
      if (!mounted) return;
      await context.read<MovieProvider>().loadMovies();
    });
  }

  void _scrollListener() {
    final offset = _scrollController.offset;
    setState(() {
      _appBarOpacity = (offset / 150).clamp(0, .8); // Control transparency
    });
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
      appBar: AppBar(
        elevation: 0,
        // pinned: true,
        backgroundColor: Colors.black.withOpacity(_appBarOpacity),
        leading: Image.asset(
          'assets/images/logo.png',
          height: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.file_download_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final movieCategories = provider.categoryLists.entries.map((entry) {
            final genreName = entry.key;
            final movies = entry.value;
            return MovieCategory(title: genreName, movies: movies);
          }).toList();

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                backgroundColor: Colors.black.withOpacity(_appBarOpacity),
                title: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildChip('Action'),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    HeroSection(featuredMovie: provider.trendingMovies.first),
                    const SizedBox(height: 20),
                    MovieCategory(title: LocaleKeys.kPopular, movies: provider.trendingMovies),
                    MovieCategory(title: LocaleKeys.kTopRated, movies: provider.topRatedMovies),
                    ...movieCategories,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey[800],
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

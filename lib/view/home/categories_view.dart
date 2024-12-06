// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/home_provider.dart';
import 'package:netflix_clone/product/constants/locale_keys.dart';
import 'package:netflix_clone/product/enums/categories.dart';
import 'package:provider/provider.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0),
              Colors.black.withOpacity(.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: IconButton.filled(
          onPressed: () => Navigator.pop(context),
          padding: const EdgeInsets.all(5),
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.black,
            size: 17,
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        child: const SizedBox(height: 41),
        builder: (context, provider, child) {
          final selectedText = provider.selectedText;
          return ListView(
            children: [
              child!,
              _BuildItem(
                text: LocaleKeys.kHomePage,
                onTap: () {
                  provider.selectText(LocaleKeys.kHomePage);
                },
                isSelected: selectedText == LocaleKeys.kHomePage,
              ),
              _BuildItem(
                text: LocaleKeys.kMyList,
                onTap: () {
                  provider.selectText(LocaleKeys.kMyList);
                },
                isSelected: selectedText == LocaleKeys.kMyList,
              ),
              ...Genres.values.map(
                (genre) => _BuildItem(
                  text: genre.english,
                  onTap: () {
                    provider.selectText(genre.english);
                  },
                  isSelected: selectedText == genre.english,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BuildItem extends StatelessWidget {
  const _BuildItem({
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Text(
          text,
          style: !isSelected ? null : const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

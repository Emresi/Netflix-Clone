// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/provider/movie_provider.dart';
import 'package:netflix_clone/view/main/main_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MainView(),
    );
  }
}

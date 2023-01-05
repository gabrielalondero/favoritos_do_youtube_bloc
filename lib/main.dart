import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube_bloc/api.dart';
import 'package:favoritos_do_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_do_youtube_bloc/blocs/videos_bloc.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  API api = API();
  api.search('gato');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((_) => VideosBloc()),
        Bloc((_) => FavoriteBloc()),
      ],
      dependencies: const [],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Favoritos YT',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Home()),
    );
  }
}

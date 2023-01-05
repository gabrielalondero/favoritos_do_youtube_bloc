import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_do_youtube_bloc/screens/video_player.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        initialData: const {},
        stream: bloc.outFav,
        builder: (context, snapshot) {
            return ListView(
              children: snapshot.data!.values.map((v) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => VideoPlayer(video: v),)
                    );
                  },
                  onLongPress: () {
                    //desfavorita
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title,
                          style: const TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );

        },
      ),
    );
  }
}

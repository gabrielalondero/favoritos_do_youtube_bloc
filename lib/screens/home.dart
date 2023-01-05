import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_do_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:favoritos_do_youtube_bloc/delegates/data_search.dart';
import 'package:favoritos_do_youtube_bloc/models/video.dart';
import 'package:favoritos_do_youtube_bloc/screens/favorites.dart';
import 'package:flutter/material.dart';

import '../blocs/videos_bloc.dart';
import '../widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<VideosBloc>();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: SizedBox(
          height: 25,
          child: Image.asset("images/yt_logo_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              initialData: const {},
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data!.length}',
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const Favorites()),
              );
            },
            icon: const Icon(Icons.star),
          ),
          IconButton(
            onPressed: () async {
              String? result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                bloc.inSearch.add(result);
              }
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      //StreamBuilder - toda vez que algo muda no bloc, a tela será refeita
      body: StreamBuilder(
        stream: bloc.outVideos,
        initialData: const [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data;
            return ListView.builder(
                itemCount: data.length + 1,
                itemBuilder: (context, index) {
                  if (index < data.length) {
                    return VideoTile(video: data[index]);
                    //se não entramos no if anterior, verificamos
                    //se já pesquisou alguma coisa e se já chegou ao fim da lista, para então carregar a próxima página
                    //quando acabamos de abrir o app só temos: lista vazia + 1, ou seja menorIgual a 1 1
                  } else if (index > 1) {
                    bloc.inSearch.add('');
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.red)),
                    );
                  }
                  return Container();
                });
          }
          return Container();
        },
      ),
    );
  }
}

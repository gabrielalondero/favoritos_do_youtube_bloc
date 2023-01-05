import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

//tirando o dado do bloc
//BehaviorSubject é 'bradcast' - ou seja a stream pode ser ouvida mais de uma vez.
  final _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

//salvar a lista de favoritos no celular
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      //se já salvou alguma vez o map de favoritos, pega o map
      if (prefs.getKeys().contains('favorites')) {
        //pega a string json e decodifica para Objeto
        Map favs = json.decode(prefs.getString('favorites')!);
        _favorites = favs.map((key, value) {
          return MapEntry(key, Video.fromJson(value));
        }).cast<String, Video>(); //para retornar o map no formato certo

        _favController.add(_favorites);
      }
    });
  }

  //colocando o dado no bloc por meio de função
  void toggleFavorite(Video video) {
    //se já está no map de favoritos, retira
    if (_favorites.containsKey(video.id)) {
      _favorites.remove(video.id);
    }
    //se não está, adiciona
    else {
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);
    _saveFav();
  }

  void _saveFav() {
    SharedPreferences.getInstance().then((prefs) => {
          //transforma em uma string json
          prefs.setString('favorites', json.encode(_favorites)),
        });
  }

  @override
  void dispose() {
    _favController.close();
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}

import 'dart:async';
import 'dart:ui';
import 'package:favoritos_do_youtube_bloc/api.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import '../models/video.dart';

class VideosBloc implements BlocBase {
  late API api;
  List<Video> videos = [];

//tirando o dado do bloc
  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

//colocando o dado no bloc por meio da stream
  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = API();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search.isNotEmpty) {
      _videosController.sink.add([]); //limpa
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
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

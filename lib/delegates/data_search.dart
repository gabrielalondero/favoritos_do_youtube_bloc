import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query =
              ''; //query é variável já existente que pega o conteúdo do campo
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      //retorna para a outra tela
      onPressed: () => close(context, ''),
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //buildResults é acionado quando clicamos na lupa de pesquisa no teclado
    //ele constroi os resultados na tela, mas vamos construir na tela enterior então:
    //Future.delayed para adiar a chamada do close até a função terminar de construir a tela atual
    //close retorna para a tela anterior, envia o que estiver no query
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: sugestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]),
                  leading: const Icon(Icons.play_arrow),
                  onTap: () {
                    //retorna para a outra tela,retorna com o resultado
                    close(context, snapshot.data?[index]);
                  },
                );
              });
        },
      );
    }
  }

  Future<List> sugestions(String search) async {
    http.Response response = await http.get(
      Uri.parse(
          'http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json'),
    );

    if (response.statusCode == 200) {
      List decoded = json.decode(response.body)[1];
      return decoded.map((v) => v[0]).toList();
    }
    throw Exception('Falha ao carregar sugestões');
  }
}

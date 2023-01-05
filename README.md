# Favoritos do youtube usando BLoC

App para exibir lista de vídeos do YouTube, favoritá-los, exibir a lista dos favoritos e dar play nos vídeos.
 - O gerenciamento de estado foi feito com BLoC.

Dependências: 

 - `youtube_player_flutter` permite abrir vídeos do youtube dentro do app;
 - `shared_preferences` permite armazenar a lista de favoritos de forma offline;
 - `bloc_pattern` ajuda na implementação do BLoC;
 - `rxdart`  deixa o BLoC mais simplificado;
 - `http`

Links:

 - `"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"`
 - `"https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken"`
 - `"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"`

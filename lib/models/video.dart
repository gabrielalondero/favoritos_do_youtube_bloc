class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
  });

//construtor
  factory Video.fromJson(Map<String, dynamic> json) {
    //formato que vem da Google
    if (json.containsKey('id')) {
      return Video(
        id: json['id']['videoId'],
        title: json['snippet']['title'],
        thumb: json['snippet']['thumbnails']['high']['url'],
        channel: json['snippet']['channelTitle'],
      );
    } else {
      //formato que vem do armazenamento local
      return Video(
        id: json['videoId'],
        title: json['title'],
        thumb: json['thumb'],
        channel: json['channel'],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'videoId': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
    };
  }

  @override
  String toString() {
    return 'Video(id: $id, title: $title, thumb: $thumb, channel: $channel)';
  }
}

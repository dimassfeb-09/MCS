class NewsSource {
  dynamic id;
  dynamic name;

  NewsSource({required this.id, required this.name});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json['id'] ?? "News doesn't have id",
      name: json['name'] ?? "News doesn't have source name",
    );
  }
}

class NewsModel {
  NewsSource source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  NewsModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: NewsSource.fromJson(json["source"]),
      author: json["author"] ?? "Nama author tidak tersedia",
      title: json["title"] ?? "Judul artikel tidak tersedia",
      description: json["description"] ?? "Deskripsi artikel tidak tersedia",
      url: json["url"] ?? "-",
      urlToImage:
          json["urlToImage"] ?? "https://demofree.sirv.com/nope-not-here.jpg",
      publishedAt: DateTime.parse(json["publishedAt"] ?? "-"),
      content: json["content"] ?? "Artikel tidak memiliki konten",
    );
  }
}

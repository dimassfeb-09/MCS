import 'dart:convert';

import 'package:http/http.dart' as http;

class Source {
  dynamic id;
  String name;

  Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}

class NewsModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
      content: json['content'] ?? '',
    );
  }

  Future<List<NewsModel>> getNews() async {
    try {
      final Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2025-10-06&sortBy=publishedAt&apiKey=7735aaca160040e7a265b83222cae677",
      );
      final response = await http.get(url);
      final responseJson = jsonDecode(response.body);
      final List<NewsModel> newsModel = responseJson['articles']
          .map((article) => NewsModel.fromJson(article))
          .toList();
      return newsModel;
    } catch (e) {
      print(e);
      return [];
    }
  }
}

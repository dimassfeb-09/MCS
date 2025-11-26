import 'package:http/http.dart' as http;
import 'dart:convert';
<<<<<<< HEAD
import 'package:mcs_bab_4/model/news_model.dart';

class NewsService {
  final universalUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2025-11-01&sortBy=publishedAt&apiKey=7735aaca160040e7a265b83222cae677";
=======
import 'package:bab4/model/news_model.dart';

class NewsService {
  final universalUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2025-08-20&sortBy=publishedAt&apiKey=defc510c04af46cb87a3f9d3898d91fb";
>>>>>>> 4a2c2892e802b90653edb29775e60bf46f7ebd3a

  Future<List<NewsModel>> getAllNewsData() async {
    final response = await http.get(Uri.parse(universalUrl));
    try {
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List articleResponse = responseBody['articles'];
        final newsResult = articleResponse
            .map((e) => NewsModel.fromJson(e))
            .toList();
        return newsResult;
      } else {
        throw Exception("[Try Error]: Failed to get data");
      }
    } catch (e) {
      throw Exception("[Catch Error]: Failed to get data");
    }
  }
}

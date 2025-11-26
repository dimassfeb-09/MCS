import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mcs_bab_4/model/news_model.dart';

class NewsService {
  final universalUrl =
      "https://newsapi.org/v2/everything?q=tesla&from=2025-11-01&sortBy=publishedAt&apiKey=7735aaca160040e7a265b83222cae677";

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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcs_bab_4/model/news_model.dart';

class AppProvider extends ChangeNotifier {
  NewsSource? source;
  late String authorName;
  late String titleOfArticle;
  late String descOfArticle;
  late String urlOfArticle;
  late String imageOfArticle;
  late DateTime publishDateTime;
  late String contentOfArticle;
  int? index;

  final titleFontStyle = GoogleFonts.oswald(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final subTitleFontStyle = GoogleFonts.robotoCondensed(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  final subTitleFontWIthStrokeStyle = GoogleFonts.robotoCondensed(
    fontSize: 17,
    color: Colors.white,
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5
        ..color = Colors.black,
    ),
  );

  final universalFontStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.white,
  );

  goToDetailNews({
    required BuildContext context,
    required NewsModel newsModel,
    required int index,
    required navigationPage,
  }) async {
    this.index = index;
    source = newsModel.source;
    authorName = newsModel.author;
    titleOfArticle = newsModel.title;
    descOfArticle = newsModel.description;
    urlOfArticle = newsModel.url;
    imageOfArticle = newsModel.urlToImage;
    publishDateTime = newsModel.publishedAt;
    contentOfArticle = newsModel.content;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => navigationPage),
    );
  }
}

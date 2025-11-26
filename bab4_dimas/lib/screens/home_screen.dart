import 'package:bab4_dimas/model/news_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NewsModel newsModel = NewsModel();

    return Scaffold(
      body: FutureBuilder(
        future: newsModel.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.data?[0].title);
            return Text("INI DATA BERITA");
          }
          return Text("");
        },
      ),
    );
  }
}

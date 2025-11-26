import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mcs_bab_4/provider/app_provider.dart';
import 'package:mcs_bab_4/screens/detail_page.dart';
import 'package:mcs_bab_4/service/news_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("MCS BAB 4", style: appProvider.titleFontStyle),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: NewsService().getAllNewsData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                final getAllArticle = snapshot.data;
                return ListView(
                  children: [
                    CarouselSlider.builder(
                      itemCount: 5,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
                      itemBuilder: (context, index, pageIndex) {
                        final getSingleArticle = getAllArticle![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            child: Stack(
                              children: [
                                Image.network(
                                  width: double.infinity,
                                  height: double.infinity,
                                  getSingleArticle.urlToImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      width: double.infinity,
                                      height: double.infinity,
                                      "https://demofree.sirv.com/nope-not-here.jpg",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Stack(
                                      children: [
                                        Text(
                                          getSingleArticle.title,
                                          style: appProvider
                                              .subTitleFontWIthStrokeStyle,
                                        ),
                                        Text(
                                          getSingleArticle.title,
                                          style: appProvider.subTitleFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              appProvider.goToDetailNews(
                                context: context,
                                newsModel: getSingleArticle,
                                index: index,
                                navigationPage: DetailPage(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: getAllArticle!.length,
                      itemBuilder: (context, index) {
                        final getSingleArticle = getAllArticle[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Row(
                              children: [
                                Image.network(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  getSingleArticle.urlToImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      "https://demofree.sirv.com/nope-not-here.jpg",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getSingleArticle.title,
                                        style: appProvider.subTitleFontStyle,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Author Name: ${getSingleArticle.author}",
                                        style: appProvider.universalFontStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              appProvider.goToDetailNews(
                                context: context,
                                newsModel: getSingleArticle,
                                index: index,
                                navigationPage: DetailPage(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bab4/provider/app_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Detail News", style: appProvider.titleFontStyle),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  appProvider.imageOfArticle,
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
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appProvider.titleOfArticle,
                      style: appProvider.titleFontStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Author", style: appProvider.universalFontStyle),
                        SizedBox(width: 50),
                        Expanded(child: Text(": ${appProvider.authorName}")),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Published",
                          style: appProvider.universalFontStyle,
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Text(
                            ": ${DateFormat("d MMMM yyyy").format(appProvider.publishDateTime)}",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Description News:",
                      style: appProvider.titleFontStyle,
                    ),
                    Text(
                      "${appProvider.descOfArticle}",
                      style: appProvider.universalFontStyle,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

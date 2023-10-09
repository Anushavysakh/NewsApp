import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_model.dart';

class ArticleScreen extends StatelessWidget {
  Articles articles;

  ArticleScreen({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 13, right: 13),
        child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(articles.title.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 10,
              ),
              Image.network(articles.urlToImage.toString()),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text("- ${articles.author.toString()}")),
              const SizedBox(
                height: 10,
              ),
              Text(
                articles.description.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ]),
      ),
    );
  }
}

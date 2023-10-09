import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_model.dart';

Widget customListTile(Articles articles) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white60, borderRadius: BorderRadius.circular(14)),
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(8),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

      Container(height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(articles.urlToImage.toString())),
            borderRadius: BorderRadius.circular(28)),
      ),
      SizedBox(
        height: 10,
      ),
      Text(articles.title.toString(),style: GoogleFonts.alegreya(),),
      // Text(articles.publishedAt.,textAlign: TextAlign.left,)
    ]),
  );
}

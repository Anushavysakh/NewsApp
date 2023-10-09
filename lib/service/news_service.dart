import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class NewsService {
  final String apiKey = 'cfad0efeb82a4712a4761c1103fb1395';
  final String baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=cfad0efeb82a4712a4761c1103fb1395';

 Future<List<Articles>> getArticle() async {
   http.Response response = await http.get(Uri.parse(baseUrl));
   if(response.statusCode ==200){
     Map<String,dynamic> jsonData = jsonDecode(response.body);
     List<dynamic> body = jsonData['articles'];
     List<Articles> articles = body.map((dynamic item) => Articles.fromJson(item)).toList();
     return articles;
   } else {
     throw("Can't get articles");
   }
 }

}

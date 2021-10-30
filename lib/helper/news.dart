import 'dart:convert';

import 'package:newsapp_flutter/model/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticalModel> news = [];
  Future<void> getNews() async {
    // ignore: unused_local_variable
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=c02ff216548c439181e1871d08293edd";
    // ignore: unused_local_variable
    var response = await http.get(url);

    // ignore: unused_local_variable
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          // ignore: unused_local_variable
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}
class CategoryNews {
  List<ArticalModel> news = [];
  Future<void> getNews(String category) async {
    // ignore: unused_local_variable
    String url =
        "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=c02ff216548c439181e1871d08293edd";
    // ignore: unused_local_variable
    var response = await http.get(url);

    // ignore: unused_local_variable
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          // ignore: unused_local_variable
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}

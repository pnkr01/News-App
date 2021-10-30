import 'package:flutter/material.dart';
import 'package:newsapp_flutter/helper/news.dart';
import 'package:newsapp_flutter/model/article_model.dart';
import 'package:newsapp_flutter/views/homepage.dart';

class CategoryView extends StatefulWidget {
  final String category;
  CategoryView({this.category});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  // ignore: deprecated_member_use
  List<ArticalModel> articles = new List<ArticalModel>();
  // ignore: unused_field
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoriesNews();
  }

  getCategoriesNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.safety_divider),
            ),
          ),
        ],
      ),
      body:  _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            ) : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
              Container(
                padding: EdgeInsets.only(top: 16.0),
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                      imgUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                  },
                ),
              ),
                      ],
                    ),
                  ),
            ),
    );
  }
}

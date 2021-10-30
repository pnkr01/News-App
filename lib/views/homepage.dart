import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_flutter/helper/data.dart';
import 'package:newsapp_flutter/helper/news.dart';
import 'package:newsapp_flutter/model/article_model.dart';
import 'package:newsapp_flutter/model/categori.dart';
import 'package:newsapp_flutter/views/articleview.dart';
import 'package:newsapp_flutter/views/categoryview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: deprecated_member_use
  List<CategoryModel> categories = List<CategoryModel>();
  // ignore: deprecated_member_use
  List<ArticalModel> articels = List<ArticalModel>();

  // ignore: unused_field
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategory();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articels = newsClass.news;
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
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    //Upper Category Part
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: 75.0,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imgUrl: categories[index].imgUrl,
                              categoryName: categories[index].categoryName,
                            );
                          }),
                    ),

                    //body part

                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        itemCount: articels.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imgUrl: articels[index].urlToImage,
                            title: articels[index].title,
                            desc: articels[index].description,
                            url: articels[index].url,
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

class CategoryTile extends StatelessWidget {
  final imgUrl, categoryName;
  CategoryTile({this.imgUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context)=> CategoryView(
              category:categoryName.toString().toLowerCase() ,
            )
            )
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 120.0,
                height: 70.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.black45,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl, title, desc, url;
  BlogTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(imgUrl),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              desc,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

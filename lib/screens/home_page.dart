import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data_helper/category_data.dart';
import 'package:news_app/data_helper/slider_data.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/screens/article_screen.dart';
import 'package:news_app/service/news_service.dart';
import 'package:news_app/widgets/custom_list_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/category_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 1;
  int activeIndex = 0;
  NewsService newsService = NewsService();

  List<SliderModel> sliders = [];
  List<SliderModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    sliders = getSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      // appBar: AppBar(actions: [
      //   IconButton(onPressed: (){}, icon: Icon(Icons.home)),
      // ],
      //   title:  Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.only(right: 50),
      //         child: Text(
      //           "News Today",
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              children: [
                Text(
                  "News Today",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),

                Container(
                  height: 170,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        ),
                      );
                    },
                  ),
                ),
                //SizedBox(height: 10,),
                CarouselSlider.builder(
                    itemCount: sliders.length,
                    itemBuilder: (context, index, realIndex) {
                      final res = sliders[index].imageUrl;
                      final resName = sliders[index].categoryName;

                      return buildImage(res!, index, resName!);
                    },
                    options: CarouselOptions(
                      animateToClosest: true,
                      height: 200,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Center(child: buildIndicator()),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: newsService.getArticle(),
                    builder: (context, AsyncSnapshot<List<Articles>> snapshot) {
                      if (snapshot.hasData) {
                        List<Articles>? articleList = snapshot.data;
                        return ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: articleList?.length,
                          itemBuilder: (context, index) {
                            count++;
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ArticleScreen(
                                      articles: articleList[index],
                                    ),
                                  ));
                                },
                                child: customListTile(articleList![index]));
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: sliders.length,
        effect:
            SlideEffect(dotColor: Colors.blue, dotHeight: 15, dotWidth: 13),
      );

  Widget buildImage(String urlImage, int index, String name) => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      );
}

class CategoryTile extends StatelessWidget {
  final String? categoryName, imageUrl;

  const CategoryTile({super.key, this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (context) => CategoryFragment(
        //     category: categoryName.toLowerCase(),
        //   ),
        // ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl.toString(),
                  width: 170,
                  height: 90,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 170,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName!,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

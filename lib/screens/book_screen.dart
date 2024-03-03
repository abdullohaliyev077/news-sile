import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:newssile/models/categories_news_model.dart';
import 'package:newssile/screens/details_screen.dart';
import 'package:newssile/view_model/news_view_model.dart';

class BookScreen extends StatefulWidget {
  BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'general';
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'ARTICALS',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              // border: Border.all(
                              //     color: Color.fromARGB(255, 142, 66, 4),
                              //     width: 1.0),
                              color: categoryName == categoriesList[index]
                                  ? Color.fromARGB(255, 180, 127, 254)
                                  : Color.fromARGB(255, 240, 240, 240),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchNewsCategoriesApi(categoryName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                        author: snapshot.data!.articles![index].author
                                            .toString(),
                                        content: snapshot
                                            .data!.articles![index].content
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        newsDate: snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        newsImage: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        newsTitle: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        source: snapshot.data!.articles![index].source!.name.toString()),
                                  ));
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 150,
                                        placeholder: (context, url) =>
                                            Container(
                                          child: Center(
                                            child: SpinKitCircle(
                                              size: 50,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      padding: EdgeInsets.only(left: 15),
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Text(
                                            maxLines: 4,
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        color: Color
                                                            .fromARGB(
                                                            255, 82, 82, 82),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    format.format(dateTime),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color:
                                                          Color.fromARGB(
                                                              255, 82, 82, 82),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

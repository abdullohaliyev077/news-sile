import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:newssile/models/categories_news_model.dart';
import 'package:newssile/models/news_channels_headlines_model.dart';
import 'package:newssile/screens/details_screen.dart';
import 'package:newssile/themes/theme_provider.dart';
import 'package:newssile/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, cnn, alJazeera, reuters, infomoney }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          Transform.scale(
            scale: 0.6,
            child: Switch(
                activeColor: Colors.white,
                value: Provider.of<ThemeProvider>(context, listen: false)
                    .isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme()),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Icon(Icons.apps)),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('NEWS',
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 225, 225, 225),
                    fontWeight: FontWeight.bold)),
            Text('sILE',
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hot News',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 78, 78, 78)),
                ),
                PopupMenuButton<FilterList>(
                  onSelected: (FilterList item) {
                    if (FilterList.bbcNews.name == item.name) {
                      name = 'bbc-news';
                    }
                    if (FilterList.aryNews.name == item.name) {
                      name = 'ary-news';
                    }
                    if (FilterList.cnn.name == item.name) {
                      name = 'cnn';
                    }
                    if (FilterList.reuters.name == item.name) {
                      name = 'reuters';
                    }
                    if (FilterList.alJazeera.name == item.name) {
                      name = 'al-jazeera-english';
                    }
                    if (FilterList.infomoney.name == item.name) {
                      name = 'info-money';
                    }
                    setState(() {
                      selectedMenu = item;
                    });
                  },
                  initialValue: selectedMenu,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<FilterList>>[
                    PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.aryNews, child: Text('ARY News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.cnn, child: Text('CNN News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.reuters, child: Text('Reuters News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.alJazeera,
                        child: Text('Al-Jazeera News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.infomoney,
                        child: Text('Info-Money News')),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: FutureBuilder<NewsChannelsHeadlinesModel>(
                future: newsViewModel.fetchNewChannelHeadlinesApi(name),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
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
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                height: 400,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 232, 231, 231),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    SizedBox(
                                      height: 150,
                                      width: 280,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            child: spinkit2,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.error_outline,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 180,
                                      child: Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          height: 300,
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 10),
                                              Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Top Rated News',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: Color
                                                            .fromARGB(
                                                            255, 88, 88, 88),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                width: 280,
                                                child: Text(
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                child: Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    236,
                                                                    127,
                                                                    3),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100)),
                                                      ),
                                                      Text(
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Color
                                                                    .fromARGB(
                                                                    255,
                                                                    88,
                                                                    88,
                                                                    88),
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        format.format(dateTime),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: Color
                                                              .fromARGB(
                                                              255, 88, 88, 88),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
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
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchNewsCategoriesApi('General'),
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
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
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
                                      placeholder: (context, url) => Container(
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
                                          snapshot.data!.articles![index].title
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
                                                      color:
                                                          Color.fromARGB(
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
                                                    color: Color.fromARGB(
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
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);

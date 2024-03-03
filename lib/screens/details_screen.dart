import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:newssile/view_model/news_view_model.dart';

class DetailsScreen extends StatefulWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  DetailsScreen(
      {super.key,
      required this.author,
      required this.content,
      required this.description,
      required this.newsDate,
      required this.newsImage,
      required this.newsTitle,
      required this.source});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: widget.newsImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    child: Text(
                      widget.newsTitle,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 236, 127, 3),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      SizedBox(width: 4),
                      Container(
                        child: Text(
                          widget.source,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 82, 82, 82)),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        format.format(dateTime),
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 82, 82, 82)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Row(
                //       children: [
                //         IconButton(
                //             onPressed: () {
                //               newsViewModel.speak(widget.description);
                //             },
                //             icon: Icon(Icons.play_arrow_rounded)),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    child: Text(
                      widget.description,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 82, 82, 82)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

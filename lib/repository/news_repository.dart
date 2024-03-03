import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newssile/models/categories_news_model.dart';
import 'package:newssile/models/news_channels_headlines_model.dart';

class NewsRepository {
  // Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
  //   String Url =
  //       'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=e574c06ad51843d29b558cf6d18090cf';
  //   final response = await http.get(Uri.parse(Url));
  //   if (kDebugMode) {
  //     print(response.body);
  //   }
  //   if (response.statusCode == 200) {
  //     final body = jsonDecode(response.body);
  //     return NewsChannelsHeadlinesModel.fromJson(body);
  //   }
  //   throw Exception('error');
  // }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category) async {
    String Url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=e574c06ad51843d29b558cf6d18090cf';
    final response = await http.get(Uri.parse(Url));
    if (kDebugMode) {
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=e574c06ad51843d29b558cf6d18090cf';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      // print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}

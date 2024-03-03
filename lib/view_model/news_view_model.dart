import 'package:newssile/models/categories_news_model.dart';

import 'package:newssile/models/news_channels_headlines_model.dart';
import 'package:newssile/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  // Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(
  //     String name) async {
  //   final response = await _rep.fetchNewsChannelsHeadlinesApi();
  //   return response;
  // }

  Future<CategoriesNewsModel> fetchNewsCategoriesApi(String category) async {
    final response = await _rep.fetchNewsCategoriesApi(category);
    return response;
  }

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }
}

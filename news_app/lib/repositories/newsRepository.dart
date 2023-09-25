import 'package:test_app/models/news.dart';
import 'package:built_collection/built_collection.dart';
import 'package:test_app/services/api/api.dart';

const LATEST_PAGE_SIZE = 20;

class NewsRepository {
  final NewsApiService _apiService;

  NewsRepository(NewsApiService apiService) : _apiService = apiService;

  Future<List<News>> getAllFeatured() async => await _apiService.getAllFeatured();

  Future<List<News>> getLatest(int page, {int limit = LATEST_PAGE_SIZE}) async => await _apiService.getLatest(page, limit);

  Future markAllRead() async => await _apiService.markAllRead();

  Future markOneRead(int id, bool isLatest) async => await _apiService.markOneRead(id, isLatest);
}

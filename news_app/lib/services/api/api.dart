import 'dart:async';
import 'package:built_collection/built_collection.dart';
import "package:dio/dio.dart";
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/repositories/storage_repository.dart';
import 'package:test_app/utils/serializers.dart';
import 'endpoints.dart';

const String baseUrl = "http://localhost:4000";

abstract class NewsApiService {
  Future<List<News>> getLatest(int page, int limit);
  Future<List<News>> getAllFeatured();
  Future markAllRead();
  Future markOneRead(int id, bool isLatest);
}

enum HTTPMethod { GET, POST, PUT, PATCH, DELETE }

class ApiService implements NewsApiService {
  late final Dio _dio;
  final StorageRepository _storageRepository;

  final cacheOptions = CacheOptions(
    store: MemCacheStore(),
    maxStale: const Duration(days: 30),
    allowPostMethod: false,
  );

  ApiService(StorageRepository storageRepository) : _storageRepository = storageRepository {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
    );
    _dio = Dio(options);

    _dio.interceptors
      ..add(LogInterceptor(responseBody: true))
      ..add(DioCacheInterceptor(options: cacheOptions))
      ..add(
        InterceptorsWrapper(
          onError: (err, handler) async {
            if (err.message == null) {
              handler.reject(DioException(requestOptions: err.requestOptions, message: "Сервер недоступен"));
            } else {
              handler.next(err);
            }
          },
        ),
      );
  }

  Future<T?> _request<T>(
    String path, {
    HTTPMethod method = HTTPMethod.GET,
    dynamic data,
    Map<String, dynamic>? queryParams,
    Options? options,
  }) async {
    final requestOptions = options ?? Options(method: method.name);
    final response = await _dio.request(path, data: data, queryParameters: queryParams, options: requestOptions);

    return deserialize<T>(response.data);
  }

  Future<List<T>> _requestList<T>(String path, {HTTPMethod method = HTTPMethod.GET, dynamic data, Map<String, dynamic>? queryParams}) async {
    final requestOptions = Options(method: method.name);
    final response = await _dio.request(path, data: data, queryParameters: queryParams, options: requestOptions);
    return deserializeListOf<T>(response.data).toList();
  }

  @override
  Future<List<News>> getLatest(int page, int limit) async {
    try {
      final queryParams = {
        "_page": page,
        "_limit": limit,
      };
      final resp = await _requestList<News>(ApiEndpoints.latestNews, queryParams: queryParams);

      return await handleOptimisticNews(resp, true);
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw "Ошибка";
    }
  }

  @override
  Future<List<News>> getAllFeatured() async {
    try {
      final resp = await _requestList<News>(ApiEndpoints.featuredNews);
      return await handleOptimisticNews(resp, false);
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw "Ошибка";
    }
  }

  @override
  Future markAllRead() async {
    await _storageRepository.setIsOptimisticMarkedAllRead();

    // in real app its simple one query
    try {
      for (var id = 1; id <= 4; id++) {
        await _request(
          "${ApiEndpoints.featuredNews}/$id",
          method: HTTPMethod.PATCH,
          data: {"isRead": true},
        );
      }
      for (var id = 5; id <= 30; id++) {
        await _request(
          "${ApiEndpoints.latestNews}/$id",
          method: HTTPMethod.PATCH,
          data: {"isRead": true},
        );
      }

      await _storageRepository.deleteIsOptimisticMarkedAllRead();
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw "Ошибка";
    }
  }

  @override
  Future markOneRead(int id, bool isLatest) async {
    try {
      final idStr = id.toString();
      await _storageRepository.setOptimisticMarkedReadId(idStr);

      await _request(
        "${isLatest ? ApiEndpoints.latestNews : ApiEndpoints.featuredNews}/$idStr",
        method: HTTPMethod.PATCH,
        data: {"isRead": true},
      );

      await _storageRepository.deleteOptimisticMarkedReadId(idStr);
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw "Ошибка";
    }
  }

  void markMultipleRead(List<String> ids, bool isLatest) async {
    for (final id in ids) {
      await markOneRead(int.parse(id), isLatest);
    }
  }

  Future<List<News>> handleOptimisticNews(List<News> news, bool isLatest) async {
    final isOptimisticMarkedAllRead = await _storageRepository.isOptimisticMarkedAllRead;
    final ids = await _storageRepository.readOptimisticMarkedReadIds() ?? [];

    if (isOptimisticMarkedAllRead) {
      markAllRead();
      return news.map((e) => e.rebuild((e) => e..isRead = true)).toList();
    } else if (ids.isNotEmpty) {
      markMultipleRead(ids, isLatest);
      return news.map((e) => ids.contains(e.id.toString()) ? e.rebuild((e) => e..isRead = true) : e).toList();
    }
    return news;
  }
}

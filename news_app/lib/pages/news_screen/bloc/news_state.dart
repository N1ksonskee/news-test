import 'package:test_app/constants/fetch_status.dart';
import 'package:test_app/models/news.dart';

class NewsState {
  final List<News> latestNews;
  final List<News> featuredNews;

  final FetchStatus latestNewsStatus;
  final FetchStatus featuredNewsStatus;

  final String latestNewsError;
  final String featuredNewsError;
  final String moreLatestNewsError;

  final bool hasReachedMaxLatest;
  final int latestPage;

  NewsState({
    required this.latestNews,
    required this.featuredNews,
    this.latestNewsStatus = FetchStatus.initial,
    this.featuredNewsStatus = FetchStatus.initial,
    this.latestNewsError = "",
    this.featuredNewsError = "",
    this.moreLatestNewsError = "",
    this.hasReachedMaxLatest = false,
    this.latestPage = 1,
  });

  NewsState copyWith({
    List<News>? latestNews,
    List<News>? featuredNews,
    FetchStatus? latestNewsStatus,
    FetchStatus? featuredNewsStatus,
    String? latestNewsError,
    String? featuredNewsError,
    String? moreLatestNewsError,
    String? markAllReadError,
    bool? hasReachedMaxLatest,
    int? latestPage,
  }) =>
      NewsState(
        latestNews: latestNews ?? this.latestNews,
        featuredNews: featuredNews ?? this.featuredNews,
        latestNewsStatus: latestNewsStatus ?? this.latestNewsStatus,
        featuredNewsStatus: featuredNewsStatus ?? this.featuredNewsStatus,
        latestNewsError: latestNewsError ?? this.latestNewsError,
        featuredNewsError: featuredNewsError ?? this.featuredNewsError,
        moreLatestNewsError: moreLatestNewsError ?? this.moreLatestNewsError,
        hasReachedMaxLatest: hasReachedMaxLatest ?? this.hasReachedMaxLatest,
        latestPage: latestPage ?? this.latestPage,
      );
}

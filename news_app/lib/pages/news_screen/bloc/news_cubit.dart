import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/constants/fetch_status.dart';
import 'package:test_app/pages/news_screen/bloc/news_state.dart';
import 'package:test_app/repositories/newsRepository.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository newsRepository;
  NewsCubit(this.newsRepository) : super(NewsState(latestNews: [], featuredNews: [])) {
    getAllFeatured();
    getLatest();
  }

  void getLatest() async {
    if (state.hasReachedMaxLatest) return;
    if (state.latestNewsStatus == FetchStatus.initial) {
      try {
        emit(state.copyWith(latestNewsStatus: FetchStatus.loading));
        final response = await newsRepository.getLatest(1);
        emit(state.copyWith(
          latestNews: response,
          latestNewsStatus: FetchStatus.success,
          latestPage: 2,
          hasReachedMaxLatest: response.length < LATEST_PAGE_SIZE,
        ));
      } catch (e) {
        emit(state.copyWith(latestNewsError: e.toString(), latestNewsStatus: FetchStatus.error));
      }
    } else {
      try {
        final response = await newsRepository.getLatest(state.latestPage);
        emit(state.copyWith(
          latestNews: [...state.latestNews, ...response],
          latestPage: state.latestPage + 1,
          hasReachedMaxLatest: response.length < LATEST_PAGE_SIZE,
        ));
      } catch (e) {
        emit(state.copyWith(moreLatestNewsError: e.toString()));
      }
    }
  }

  void getAllFeatured() async {
    try {
      emit(state.copyWith(featuredNewsStatus: FetchStatus.loading));
      final response = await newsRepository.getAllFeatured();
      emit(state.copyWith(featuredNews: response, featuredNewsStatus: FetchStatus.success));
    } catch (e) {
      emit(state.copyWith(featuredNewsError: e.toString(), featuredNewsStatus: FetchStatus.error));
    }
  }

  Future<void> refreshLatest() async {
    emit(NewsState(latestNews: [], featuredNews: []));
    getLatest();
    getAllFeatured();
  }

  void markAllRead() {
    // optimistic update
    newsRepository.markAllRead();

    var fn = state.featuredNews;
    var ln = state.latestNews;

    fn = fn.map((e) => e.rebuild((b) => b..isRead = true)).toList();
    ln = ln.map((e) => e.rebuild((b) => b..isRead = true)).toList();

    emit(state.copyWith(featuredNews: fn, latestNews: ln));
  }

  void markSingleRead(int id, int index, isLatest) {
    // optimistic update
    newsRepository.markOneRead(id, isLatest);

    var fn = state.featuredNews;
    var ln = state.latestNews;

    if (isLatest) {
      ln[index] = ln[index].rebuild((b) => b..isRead = true);
    } else {
      fn[index] = fn[index].rebuild((b) => b..isRead = true);
    }

    emit(state.copyWith(featuredNews: fn, latestNews: ln));
  }
}

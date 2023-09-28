import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:test_app/constants/fetch_status.dart';
import 'package:test_app/hooks/use_debounce.dart';
import 'package:test_app/hooks/use_trottle.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/navigation/routes.dart';
import 'package:test_app/pages/news_screen/bloc/featured_height_cubit.dart';
import 'package:test_app/pages/news_screen/bloc/news_cubit.dart';
import 'package:test_app/pages/news_screen/bloc/news_state.dart';
import 'package:test_app/pages/news_screen/widgets/featured_news_tile.dart';
import 'package:test_app/pages/news_screen/widgets/menu_item.dart';
import 'package:test_app/pages/news_screen/widgets/news_tile.dart';
import 'package:test_app/pages/news_screen/widgets/news_title.dart';
import 'package:test_app/pages/news_screen/widgets/shimmer_news_list.dart';
import 'package:test_app/themes/color_pallete.dart';
import 'package:test_app/utils/show_toast.dart';
import 'package:test_app/widgets/error_container.dart';
import 'package:test_app/widgets/news_app_bar.dart';
import 'package:test_app/widgets/center_indecator.dart';

class NewsScreen extends HookWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ftoast = FToast().init(context);
    final scrollController = useScrollController();
    final trottle = useTrottle();

    void onScroll() {
      if (!scrollController.hasClients) return;
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (currentScroll == maxScroll) {
        context.read<NewsCubit>().getLatest();
      }

      if (currentScroll > 0 && currentScroll < 100) {
        context.read<FeaturedHeightCubit>().update(FEATURED_FULL_HEIGHT - currentScroll * 1.8);
      } else if (currentScroll <= 0) {
        context.read<FeaturedHeightCubit>().update(FEATURED_FULL_HEIGHT);
      }
    }

    scrollController.addListener(onScroll);

    onTapNews(News news, int index, bool islatest) {
      context.pushNamed(RouteNames.news_single, extra: {"news": news});
      if (!news.isRead) {
        context.read<NewsCubit>().markSingleRead(news.id, index, islatest);
      }
    }

    return SafeArea(
      child: BlocConsumer<NewsCubit, NewsState>(
        listenWhen: (prev, current) => prev.moreLatestNewsError != current.moreLatestNewsError,
        listener: (conext, state) {
          if (state.moreLatestNewsError.isNotEmpty) {
            showToast(ftoast, state.moreLatestNewsError);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: NewsAppBar(
            actions: [
              MenuItem(
                title: "Notifications",
                onTap: () {},
              ),
              MenuItem(
                title: "Mark all read",
                onTap: state.newsLoaded
                    ? () {
                        trottle(
                          fn: () {
                            context.read<NewsCubit>().markAllRead();
                            showToast(ftoast, "All news is marked as read");
                          },
                          waitForMs: 5000,
                        );
                      }
                    : () => showToast(ftoast, "Wait until news are loaded", seconds: 1),
              ),
            ],
          ),
          body: RefreshIndicator(
            color: NewsColors.textPrimary,
            onRefresh: context.read<NewsCubit>().refreshLatest,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 28),
              controller: scrollController,
              children: [
                const NewsTitle(title: "Featured"),
                if (state.featuredNewsStatus == FetchStatus.loading)
                  const CenterIndicator(height: FEATURED_FULL_HEIGHT)
                else if (state.featuredNewsStatus == FetchStatus.success)
                  BlocBuilder<FeaturedHeightCubit, double>(
                    builder: (context, height) => SizedBox(
                      height: height,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: FEATURED_VERTICAL_PADDING),
                        itemBuilder: (context, i) => FeaturedNewsTile(
                          news: state.featuredNews[i],
                          height: height,
                          onTap: () => onTapNews(state.featuredNews[i], i, false),
                        ),
                        itemCount: state.featuredNews.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 28),
                      ),
                    ),
                  )
                else
                  ErrorContainer(error: state.featuredNewsError),
                const NewsTitle(title: "Latest news"),
                const SizedBox(height: 18),
                if (state.latestNewsStatus == FetchStatus.loading)
                  const ShimmerNewsList()
                else if (state.latestNewsStatus == FetchStatus.success)
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => i >= state.latestNews.length
                        ? const CenterIndicator()
                        : NewsTile(
                            news: state.latestNews[i],
                            onTap: () => onTapNews(state.latestNews[i], i, true),
                          ),
                    itemCount: state.hasReachedMaxLatest ? state.latestNews.length : state.latestNews.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                  )
                else
                  ErrorContainer(error: state.latestNewsError),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

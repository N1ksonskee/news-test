import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:test_app/pages/news_screen/bloc/featured_height_cubit.dart";
import "package:test_app/pages/news_screen/news_screen.dart";
import 'package:test_app/pages/news_single_screen.dart/news_single_screen.dart';

const initialRoute = '/${RouteNames.news}';

final goRouter = GoRouter(
  initialLocation: initialRoute,
  routes: <GoRoute>[
    GoRoute(
      path: initialRoute,
      name: RouteNames.news,
      builder: (BuildContext context, GoRouterState state) => BlocProvider(
        create: (_) => FeaturedHeightCubit(),
        child:  const NewsScreen(),
      ),
      routes: [
        GoRoute(
          path: RouteNames.news_single,
          name: RouteNames.news_single,
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>;
            return NewsSingleScreen(news: extra["news"]);
          },
        ),
      ],
    ),
  ],
);

abstract class RouteNames {
  static const String news = 'news';
  static const String news_single = 'news_single';
}

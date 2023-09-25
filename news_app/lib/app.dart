import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/navigation/routes.dart';
import 'package:test_app/pages/news_screen/bloc/news_cubit.dart';
import 'package:test_app/repositories/newsRepository.dart';
import 'package:test_app/themes/color_pallete.dart';

class TestApp extends StatelessWidget {
  final NewsRepository _newsRepository;

  const TestApp({
    super.key,
    required newsRepository,
  }) : _newsRepository = newsRepository;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: _newsRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => NewsCubit(_newsRepository)),
          ],
          child: MaterialApp.router(
            routerConfig: goRouter,
            title: "News app",
            theme: ThemeData(
              fontFamily: "Open Sans",
              scaffoldBackgroundColor: NewsColors.bg,
              appBarTheme: const AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
              ),
            ),
          ),
        ),
      );
}

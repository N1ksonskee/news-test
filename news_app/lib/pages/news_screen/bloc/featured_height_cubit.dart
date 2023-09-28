import 'package:flutter_bloc/flutter_bloc.dart';

const double FEATURED_VERTICAL_PADDING = 30;
const double FEATURED_HEIGHT = 300;
const double FEATURED_FULL_HEIGHT = FEATURED_VERTICAL_PADDING + FEATURED_HEIGHT;

// make cubit for prevent useless updates

class FeaturedHeightCubit extends Cubit<double> {
  FeaturedHeightCubit() : super(FEATURED_FULL_HEIGHT);

  update(double value) => emit(value);
}
import 'package:flutter_bloc/flutter_bloc.dart';

const double FEATURED_PADDING = 30;
const double FEATURED_SIZE = 300;

// make cubit for prevent useless updates

class FeaturedHeightCubit extends Cubit<double> {
  FeaturedHeightCubit() : super(FEATURED_PADDING + FEATURED_SIZE);

  update(double value) => emit(value);
}
part of 'popular_tv_shows_bloc.dart';

@immutable
abstract class PopularTVShowsEvent extends Equatable {}

class OnPopularTVShowsCalled extends PopularTVShowsEvent {
  @override
  List<Object> get props => [];
}

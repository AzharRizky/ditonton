part of 'top_rated_tv_shows_bloc.dart';

@immutable
abstract class TopRatedTVShowsEvent extends Equatable {}

class OnTopRatedTVShowsCalled extends TopRatedTVShowsEvent {
  @override
  List<Object> get props => [];
}

part of 'top_rated_tv_shows_bloc.dart';

@immutable
abstract class TopRatedTVShowsState extends Equatable {}

class TopRatedTVShowsEmpty extends TopRatedTVShowsState {
  @override
  List<Object> get props => [];
}

class TopRatedTVShowsLoading extends TopRatedTVShowsState {
  @override
  List<Object> get props => [];
}

class TopRatedTVShowsError extends TopRatedTVShowsState {
  final String message;

  TopRatedTVShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTVShowsHasData extends TopRatedTVShowsState {
  final List<TVShow> result;

  TopRatedTVShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

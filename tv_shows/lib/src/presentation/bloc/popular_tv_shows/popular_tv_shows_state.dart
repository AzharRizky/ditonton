part of 'popular_tv_shows_bloc.dart';

@immutable
abstract class PopularTVShowsState extends Equatable {}

class PopularTVShowsEmpty extends PopularTVShowsState {
  @override
  List<Object> get props => [];
}

class PopularTVShowsLoading extends PopularTVShowsState {
  @override
  List<Object> get props => [];
}

class PopularTVShowsError extends PopularTVShowsState {
  final String message;

  PopularTVShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTVShowsHasData extends PopularTVShowsState {
  final List<TVShow> result;

  PopularTVShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

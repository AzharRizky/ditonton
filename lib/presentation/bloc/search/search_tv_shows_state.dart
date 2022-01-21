part of 'search_tv_shows_bloc.dart';

@immutable
abstract class SearchTVShowsState extends Equatable {}

class SearchTVShowsInitial extends SearchTVShowsState {
  @override
  List<Object> get props => [];
}

class SearchTVShowsEmpty extends SearchTVShowsState {
  @override
  List<Object> get props => [];
}

class SearchTVShowsLoading extends SearchTVShowsState {
  @override
  List<Object> get props => [];
}

class SearchTVShowsError extends SearchTVShowsState {
  final String message;

  SearchTVShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTVShowsHasData extends SearchTVShowsState {
  final List<TVShow> result;

  SearchTVShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

part of 'watchlist_tv_shows_bloc.dart';

@immutable
abstract class WatchlistTVShowsState extends Equatable {}

class TVShowWatchlistInitial extends WatchlistTVShowsState {
  @override
  List<Object> get props => [];
}

class TVShowWatchlistEmpty extends WatchlistTVShowsState {
  @override
  List<Object> get props => [];
}

class TVShowWatchlistLoading extends WatchlistTVShowsState {
  @override
  List<Object> get props => [];
}

class TVShowWatchlistError extends WatchlistTVShowsState {
  final String message;

  TVShowWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TVShowWatchlistHasData extends WatchlistTVShowsState {
  final List<TVShow> result;

  TVShowWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TVShowIsAddedToWatchlist extends WatchlistTVShowsState {
  final bool isAdded;

  TVShowIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TVShowWatchlistMessage extends WatchlistTVShowsState {
  final String message;

  TVShowWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

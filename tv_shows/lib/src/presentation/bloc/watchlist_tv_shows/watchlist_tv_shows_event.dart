part of 'watchlist_tv_shows_bloc.dart';

@immutable
abstract class WatchlistTVShowsEvent extends Equatable {}

class OnFetchTVShowWatchlist extends WatchlistTVShowsEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchlistStatus extends WatchlistTVShowsEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddTVShowToWatchlist extends WatchlistTVShowsEvent {
  final TVShowDetail tvShow;

  AddTVShowToWatchlist(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}

class RemoveTVShowFromWatchlist extends WatchlistTVShowsEvent {
  final TVShowDetail tvShow;

  RemoveTVShowFromWatchlist(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}

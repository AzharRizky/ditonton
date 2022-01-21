part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesEvent extends Equatable {}

class OnFetchMovieWatchlist extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchlistStatus extends WatchlistMoviesEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddMovieToWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  AddMovieToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieFromWatchlist extends WatchlistMoviesEvent {
  final MovieDetail movie;

  RemoveMovieFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

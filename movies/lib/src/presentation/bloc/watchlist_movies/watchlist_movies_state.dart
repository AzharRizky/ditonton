part of 'watchlist_movies_bloc.dart';

@immutable
abstract class WatchlistMoviesState extends Equatable {}

class MovieWatchlistInitial extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistEmpty extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistError extends WatchlistMoviesState {
  final String message;

  MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends WatchlistMoviesState {
  final List<Movie> result;

  MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieIsAddedToWatchlist extends WatchlistMoviesState {
  final bool isAdded;

  MovieIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieWatchlistMessage extends WatchlistMoviesState {
  final String message;

  MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

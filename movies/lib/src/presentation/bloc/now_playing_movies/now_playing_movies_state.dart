part of 'now_playing_movies_bloc.dart';

@immutable
abstract class NowPlayingMoviesState extends Equatable {}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  @override
  List<Object> get props => [];
}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

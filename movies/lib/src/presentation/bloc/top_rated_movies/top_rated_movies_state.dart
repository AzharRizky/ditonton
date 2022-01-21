part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesState extends Equatable {}

class TopRatedMoviesEmpty extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object> get props => [];
}

class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> result;

  TopRatedMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

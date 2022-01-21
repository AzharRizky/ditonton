part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesState extends Equatable {}

class SearchMoviesInitial extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

class SearchMoviesEmpty extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

class SearchMoviesLoading extends SearchMoviesState {
  @override
  List<Object> get props => [];
}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchMoviesHasData extends SearchMoviesState {
  final List<Movie> result;

  SearchMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}

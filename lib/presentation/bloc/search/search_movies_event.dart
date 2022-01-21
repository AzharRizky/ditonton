part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesEvent extends Equatable {}

class OnQueryMoviesChange extends SearchMoviesEvent {
  final String query;

  OnQueryMoviesChange(this.query);

  @override
  List<Object> get props => [query];
}

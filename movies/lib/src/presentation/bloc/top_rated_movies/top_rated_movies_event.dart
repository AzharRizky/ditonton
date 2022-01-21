part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesEvent extends Equatable {}

class OnTopRatedMoviesCalled extends TopRatedMoviesEvent {
  @override
  List<Object> get props => [];
}

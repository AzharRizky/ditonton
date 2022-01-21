part of 'movie_recommendations_bloc.dart';

@immutable
abstract class MovieRecommendationsState extends Equatable {}

class MovieRecommendationsEmpty extends MovieRecommendationsState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsLoading extends MovieRecommendationsState {
  @override
  List<Object> get props => [];
}

class MovieRecommendationsError extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsHasData extends MovieRecommendationsState {
  final List<Movie> result;

  MovieRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}

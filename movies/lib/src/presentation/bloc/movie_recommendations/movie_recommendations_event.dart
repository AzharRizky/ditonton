part of 'movie_recommendations_bloc.dart';

@immutable
abstract class MovieRecommendationsEvent extends Equatable {}

class OnMovieRecommendationsCalled extends MovieRecommendationsEvent {
  final int id;

  OnMovieRecommendationsCalled(this.id);

  @override
  List<Object> get props => [id];
}

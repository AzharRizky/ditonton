part of 'tv_show_recommendations_bloc.dart';

@immutable
abstract class TVShowRecommendationsEvent extends Equatable {}

class OnTVShowRecommendationsCalled extends TVShowRecommendationsEvent {
  final int id;

  OnTVShowRecommendationsCalled(this.id);

  @override
  List<Object> get props => [id];
}

part of 'tv_show_recommendations_bloc.dart';

@immutable
abstract class TVShowRecommendationsState extends Equatable {}

class TVShowRecommendationsEmpty extends TVShowRecommendationsState {
  @override
  List<Object> get props => [];
}

class TVShowRecommendationsLoading extends TVShowRecommendationsState {
  @override
  List<Object> get props => [];
}

class TVShowRecommendationsError extends TVShowRecommendationsState {
  final String message;

  TVShowRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TVShowRecommendationsHasData extends TVShowRecommendationsState {
  final List<TVShow> result;

  TVShowRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}

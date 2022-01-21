import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetTVShowRecommendations, TVShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tv_show_recommendations_event.dart';
part 'tv_show_recommendations_state.dart';

class TVShowRecommendationsBloc
    extends Bloc<TVShowRecommendationsEvent, TVShowRecommendationsState> {
  final GetTVShowRecommendations _getTVShowRecommendations;

  TVShowRecommendationsBloc(this._getTVShowRecommendations)
      : super(TVShowRecommendationsEmpty()) {
    on<OnTVShowRecommendationsCalled>(_onTVShowRecommendationsCalled);
  }

  FutureOr<void> _onTVShowRecommendationsCalled(
    OnTVShowRecommendationsCalled event,
    Emitter<TVShowRecommendationsState> emit,
  ) async {
    final id = event.id;
    emit(TVShowRecommendationsLoading());

    final result = await _getTVShowRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(TVShowRecommendationsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TVShowRecommendationsEmpty())
            : emit(TVShowRecommendationsHasData(data));
      },
    );
  }
}

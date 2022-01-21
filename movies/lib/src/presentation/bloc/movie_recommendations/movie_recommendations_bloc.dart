import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetMovieRecommendations, Movie;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieRecommendationsEmpty()) {
    on<OnMovieRecommendationsCalled>(_onMovieRecommendationsCalled);
  }

  FutureOr<void> _onMovieRecommendationsCalled(
    OnMovieRecommendationsCalled event,
    Emitter<MovieRecommendationsState> emit,
  ) async {
    final id = event.id;
    emit(MovieRecommendationsLoading());

    final result = await _getMovieRecommendations.execute(id);

    result.fold(
      (failure) {
        emit(MovieRecommendationsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(MovieRecommendationsEmpty())
            : emit(MovieRecommendationsHasData(data));
      },
    );
  }
}

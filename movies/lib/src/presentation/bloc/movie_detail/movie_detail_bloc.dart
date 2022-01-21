import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetMovieDetail, MovieDetail;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<OnMovieDetailCalled>(_onMovieDetailCalled);
  }

  FutureOr<void> _onMovieDetailCalled(
    OnMovieDetailCalled event,
    Emitter<MovieDetailState> emit,
  ) async {
    final id = event.id;

    emit(MovieDetailLoading());

    final result = await _getMovieDetail.execute(id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (data) {
        emit(MovieDetailHasData(data));
      },
    );
  }
}

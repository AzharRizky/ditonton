import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetPopularMovies, Movie;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnPopularMoviesCalled>(_onPopularMoviesCalled);
  }

  FutureOr<void> _onPopularMoviesCalled(
    OnPopularMoviesCalled event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(PopularMoviesEmpty())
            : emit(PopularMoviesHasData(data));
      },
    );
  }
}

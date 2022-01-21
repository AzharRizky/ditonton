import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart'
    show
        GetWatchListStatusMovie,
        GetWatchlistMovies,
        Movie,
        MovieDetail,
        RemoveWatchlistMovie,
        SaveWatchlistMovie;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatusMovie _getWatchlistStatus;
  final RemoveWatchlistMovie _removeWatchlist;
  final SaveWatchlistMovie _saveWatchlist;

  WatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(MovieWatchlistInitial()) {
    on<OnFetchMovieWatchlist>(_onFetchMovieWatchlist);
    on<FetchWatchlistStatus>(_fetchWatchlistStatus);
    on<AddMovieToWatchlist>(_addMovieToWatchlist);
    on<RemoveMovieFromWatchlist>(_removeMovieFromWatchlist);
  }

  FutureOr<void> _onFetchMovieWatchlist(
    OnFetchMovieWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(MovieWatchlistLoading());

    final result = await _getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(MovieWatchlistEmpty())
            : emit(MovieWatchlistHasData(data));
      },
    );
  }

  FutureOr<void> _fetchWatchlistStatus(
    FetchWatchlistStatus event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(MovieIsAddedToWatchlist(result));
  }

  FutureOr<void> _addMovieToWatchlist(
    AddMovieToWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _saveWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (message) {
        emit(MovieWatchlistMessage(message));
      },
    );
  }

  FutureOr<void> _removeMovieFromWatchlist(
    RemoveMovieFromWatchlist event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    final movie = event.movie;

    final result = await _removeWatchlist.execute(movie);

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (message) {
        emit(MovieWatchlistMessage(message));
      },
    );
  }
}

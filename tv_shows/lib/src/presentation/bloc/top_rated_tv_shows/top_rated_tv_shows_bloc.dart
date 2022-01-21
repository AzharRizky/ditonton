import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetTopRatedTVShows, TVShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'top_rated_tv_shows_event.dart';
part 'top_rated_tv_shows_state.dart';

class TopRatedTVShowsBloc
    extends Bloc<TopRatedTVShowsEvent, TopRatedTVShowsState> {
  final GetTopRatedTVShows _getTopRatedTVShows;

  TopRatedTVShowsBloc(this._getTopRatedTVShows)
      : super(TopRatedTVShowsEmpty()) {
    on<OnTopRatedTVShowsCalled>(_onTopRatedTVShowsCalled);
  }

  FutureOr<void> _onTopRatedTVShowsCalled(
    OnTopRatedTVShowsCalled event,
    Emitter<TopRatedTVShowsState> emit,
  ) async {
    emit(TopRatedTVShowsLoading());

    final result = await _getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        emit(TopRatedTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(TopRatedTVShowsEmpty())
            : emit(TopRatedTVShowsHasData(data));
      },
    );
  }
}

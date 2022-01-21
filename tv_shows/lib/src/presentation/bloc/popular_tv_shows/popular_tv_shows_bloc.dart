import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetPopularTVShows, TVShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTVShowsBloc
    extends Bloc<PopularTVShowsEvent, PopularTVShowsState> {
  final GetPopularTVShows _getPopularTVShows;

  PopularTVShowsBloc(this._getPopularTVShows) : super(PopularTVShowsEmpty()) {
    on<OnPopularTVShowsCalled>(_onPopularTVShowsCalled);
  }

  FutureOr<void> _onPopularTVShowsCalled(
    OnPopularTVShowsCalled event,
    Emitter<PopularTVShowsState> emit,
  ) async {
    emit(PopularTVShowsLoading());

    final result = await _getPopularTVShows.execute();

    result.fold(
      (failure) {
        emit(PopularTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(PopularTVShowsEmpty())
            : emit(PopularTVShowsHasData(data));
      },
    );
  }
}

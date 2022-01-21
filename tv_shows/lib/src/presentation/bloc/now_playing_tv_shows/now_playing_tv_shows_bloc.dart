import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show GetNowPlayingTVShows, TVShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'now_playing_tv_shows_event.dart';
part 'now_playing_tv_shows_state.dart';

class NowPlayingTVShowsBloc
    extends Bloc<NowPlayingTVShowsEvent, NowPlayingTVShowsState> {
  final GetNowPlayingTVShows _getNowPlayingTVShows;

  NowPlayingTVShowsBloc(
    this._getNowPlayingTVShows,
  ) : super(NowPlayingTVShowsEmpty()) {
    on<OnNowPlayingTVShowsCalled>(_onNowPlayingTVShowsCalled);
  }

  FutureOr<void> _onNowPlayingTVShowsCalled(NowPlayingTVShowsEvent event,
      Emitter<NowPlayingTVShowsState> emit) async {
    emit(NowPlayingTVShowsLoading());

    final result = await _getNowPlayingTVShows.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(NowPlayingTVShowsEmpty())
            : emit(NowPlayingTVShowsHasData(data));
      },
    );
  }
}

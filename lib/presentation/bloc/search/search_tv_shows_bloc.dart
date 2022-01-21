import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show SearchTVShows, TVShow;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_shows_event.dart';
part 'search_tv_shows_state.dart';

class SearchTVShowsBloc extends Bloc<SearchTVShowsEvent, SearchTVShowsState> {
  final SearchTVShows _searchTVShows;

  SearchTVShowsBloc(this._searchTVShows) : super(SearchTVShowsInitial()) {
    on<OnQueryTVShowsChange>(_onQueryTVShowsChange);
  }

  FutureOr<void> _onQueryTVShowsChange(
      OnQueryTVShowsChange event, Emitter<SearchTVShowsState> emit) async {
    final query = event.query;
    emit(SearchTVShowsEmpty());

    final result = await _searchTVShows.execute(query);

    result.fold(
      (failure) {
        emit(SearchTVShowsError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchTVShowsEmpty())
            : emit(SearchTVShowsHasData(data));
      },
    );
  }

  @override
  Stream<SearchTVShowsState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}

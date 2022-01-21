import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart' show Movie, SearchMovies;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies _searchMovies;

  SearchMoviesBloc(this._searchMovies) : super(SearchMoviesInitial()) {
    on<OnQueryMoviesChange>(_onQueryMoviesChange);
  }

  FutureOr<void> _onQueryMoviesChange(
      OnQueryMoviesChange event, Emitter<SearchMoviesState> emit) async {
    final query = event.query;
    emit(SearchMoviesLoading());

    final result = await _searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchMoviesError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(SearchMoviesEmpty())
            : emit(SearchMoviesHasData(data));
      },
    );
  }

  @override
  Stream<SearchMoviesState> get stream =>
      super.stream.debounceTime(const Duration(milliseconds: 200));
}

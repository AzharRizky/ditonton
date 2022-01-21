import 'package:core/core.dart'
    show Movie, RequestState, SearchMovies, SearchTVShows, TVShow;
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTVShows searchTVShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTVShows,
  });

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Movie> _moviesSearchResult = [];

  List<Movie> get moviesSearchResult => _moviesSearchResult;

  List<TVShow> _tvShowsSearchResult = [];

  List<TVShow> get tvShowsSearchResult => _tvShowsSearchResult;

  String _message = '';

  String get message => _message;

  void resetData() {
    _state = RequestState.empty;
    _moviesSearchResult = [];
    _tvShowsSearchResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _moviesSearchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVShowSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTVShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _tvShowsSearchResult = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}

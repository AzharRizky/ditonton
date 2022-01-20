import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTVShows searchTVShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTVShows,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _moviesSearchResult = [];
  List<Movie> get moviesSearchResult => _moviesSearchResult;

  List<TVShow> _tvShowsSearchResult = [];
  List<TVShow> get tvShowsSearchResult => _tvShowsSearchResult;

  String _message = '';
  String get message => _message;

  void resetData() {
    _state = RequestState.Empty;
    _moviesSearchResult = [];
    _tvShowsSearchResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _moviesSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVShowSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _tvShowsSearchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

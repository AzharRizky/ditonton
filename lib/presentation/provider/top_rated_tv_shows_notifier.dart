import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TopRatedTVShowsNotifier extends ChangeNotifier {
  final GetTopRatedTVShows getTopRatedTVShows;

  TopRatedTVShowsNotifier({required this.getTopRatedTVShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVShow> _tvShows = [];
  List<TVShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTVShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}

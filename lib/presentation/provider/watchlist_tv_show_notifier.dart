import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistTVShowNotifier extends ChangeNotifier {
  var _watchlistTVShows = <TVShow>[];
  List<TVShow> get watchlistTVShows => _watchlistTVShows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTVShowNotifier({required this.getWatchlistTVShows});

  final GetWatchlistTVShows getWatchlistTVShows;

  Future<void> fetchWatchlistTVShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTVShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}

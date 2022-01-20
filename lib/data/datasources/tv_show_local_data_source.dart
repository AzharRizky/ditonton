import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_show_table.dart';

abstract class TVShowLocalDataSource {
  Future<String> insertWatchlist(TVShowTable tvShow);
  Future<String> removeWatchlist(TVShowTable tvShow);
  Future<TVShowTable?> getTVShowById(int id);
  Future<List<TVShowTable>> getWatchlistTVShows();
}

class TVShowLocalDataSourceImpl implements TVShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TVShowTable?> getTVShowById(int id) async {
    final result = await databaseHelper.getTVShowById(id);
    if (result != null) {
      return TVShowTable.fromMap(result);
    } else
      return null;
  }

  @override
  Future<List<TVShowTable>> getWatchlistTVShows() async {
    final result = await databaseHelper.getWatchlistTVShows();
    return result.map((data) => TVShowTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TVShowTable tvShow) async {
    try {
      await databaseHelper.insertTVShowWatchlist(tvShow);
      return WATCHLIST_ADD_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVShowTable tvShow) async {
    try {
      await databaseHelper.removeTVShowWatchlist(tvShow);
      return WATCHLIST_REMOVE_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

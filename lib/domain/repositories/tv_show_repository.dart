import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

abstract class TVShowRepository {
  Future<Either<Failure, List<TVShow>>> getNowPlayingTVShows();
  Future<Either<Failure, List<TVShow>>> getPopularTVShows();
  Future<Either<Failure, List<TVShow>>> getTopRatedTVShows();
  Future<Either<Failure, TVShowDetail>> getTVShowDetail(int id);
  Future<Either<Failure, List<TVShow>>> getTVShowRecommendations(int id);
  Future<Either<Failure, List<TVShow>>> searchTVShows(String query);
  Future<Either<Failure, String>> saveWatchlist(TVShowDetail tvShow);
  Future<Either<Failure, String>> removeWatchlist(TVShowDetail tvShow);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVShow>>> getWatchlistTVShows();
}

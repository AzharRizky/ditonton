import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetWatchlistTVShows {
  final TVShowRepository _repository;

  GetWatchlistTVShows(this._repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return _repository.getWatchlistTVShows();
  }
}

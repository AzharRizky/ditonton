import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/tv_show_detail.dart';
import 'package:core/src/domain/repositories/tv_show_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTVShow {
  final TVShowRepository repository;

  RemoveWatchlistTVShow(this.repository);

  Future<Either<Failure, String>> execute(TVShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}

import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/movie_detail.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistMovie {
  final MovieRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}

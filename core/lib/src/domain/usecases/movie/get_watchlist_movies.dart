import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/movie.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}

import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/movie.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}

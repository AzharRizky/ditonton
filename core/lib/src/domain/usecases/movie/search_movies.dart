import 'package:dartz/dartz.dart';
import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/movie.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';

class SearchMovies {
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class RemoveWatchlist {
  final TVShowRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVShowDetail movie) {
    return repository.removeWatchlist(movie);
  }
}

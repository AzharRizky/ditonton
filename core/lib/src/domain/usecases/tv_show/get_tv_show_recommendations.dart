import 'package:core/src/common/failure.dart';
import 'package:core/src/domain/entities/tv_show.dart';
import 'package:core/src/domain/repositories/tv_show_repository.dart';
import 'package:dartz/dartz.dart';

class GetTVShowRecommendations {
  final TVShowRepository repository;

  GetTVShowRecommendations(this.repository);

  Future<Either<Failure, List<TVShow>>> execute(id) {
    return repository.getTVShowRecommendations(id);
  }
}

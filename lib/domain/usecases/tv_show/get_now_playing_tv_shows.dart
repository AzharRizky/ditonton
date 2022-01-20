import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetNowPlayingTVShows {
  final TVShowRepository repository;

  GetNowPlayingTVShows(this.repository);

  Future<Either<Failure, List<TVShow>>> execute() {
    return repository.getNowPlayingTVShows();
  }
}

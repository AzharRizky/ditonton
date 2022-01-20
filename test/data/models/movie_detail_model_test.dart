import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final testMovieResponse = MovieDetailResponse(
    popularity: 1,
    posterPath: 'posterPath',
    title: 'title',
    releaseDate: 'releaseDate',
    genres: [],
    imdbId: 'imdbId',
    video: false,
    runtime: 1,
    id: 1,
    overview: 'overview',
    voteCount: 1,
    adult: false,
    revenue: 1,
    tagline: 'tagline',
    originalTitle: 'originalTitle',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    backdropPath: 'backdropPath',
    budget: 2,
    status: 'status',
  );

  final testMovieDetail = testMovieResponse.toEntity();
  final testMovieMap = testMovieResponse.toJson();

  test('should be a subclass of MovieDetail entity', () async {
    final result = testMovieResponse.toEntity();
    expect(result, testMovieDetail);
  });

  test('should be a map of movie', () async {
    final result = testMovieResponse.toJson();
    expect(result, testMovieMap);
  });

  test('should be a MovieDetailResponse instance', () async {
    final result = MovieDetailResponse.fromJson(testMovieMap);
    expect(result, testMovieResponse);
  });
}

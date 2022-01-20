import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final testTVShowResponse = TVShowDetailResponse(
    popularity: 1,
    posterPath: 'posterPath',
    name: 'name',
    type: 'type',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    seasons: [],
    episodeRunTime: [1],
    firstAirDate: 'firstAirDate',
    genres: [],
    id: 1,
    overview: 'overview',
    voteCount: 1,
    tagline: 'tagline',
    originalName: 'originalName',
    homepage: 'homepage',
    voteAverage: 1,
    originalLanguage: 'originalLanguage',
    backdropPath: 'backdropPath',
    status: 'status',
  );

  final testTVShowDetail = testTVShowResponse.toEntity();
  final testTVShowMap = testTVShowResponse.toJson();

  test('should be a subclass of TVShowDetail entity', () async {
    final result = testTVShowResponse.toEntity();
    expect(result, testTVShowDetail);
  });

  test('should be a map of TVShow', () async {
    final result = testTVShowResponse.toJson();
    expect(result, testTVShowMap);
  });

  test('should be a TVShowDetailResponse instance', () async {
    final result = TVShowDetailResponse.fromJson(testTVShowMap);
    expect(result, testTVShowResponse);
  });
}

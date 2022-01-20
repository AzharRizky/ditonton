import 'package:ditonton/data/models/season_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final testSeasonModel = SeasonModel(
    id: 1,
    name: 'season',
    posterPath: 'poster',
    episodeCount: 2,
    seasonNumber: 2,
    airDate: '',
    overview: '',
  );

  final testSeason = testSeasonModel.toEntity();

  final testSeasonMap = testSeasonModel.toJson();

  group('SeasonModel test', () {
    test('should be a subclass of Season entity', () async {
      final result = testSeasonModel.toEntity();
      expect(result, testSeason);
    });

    test('should be a map of season', () async {
      final result = testSeasonModel.toJson();
      expect(result, testSeasonMap);
    });

    test('should be a SeasonModel entity instance', () async {
      final result = SeasonModel.fromJson(testSeasonMap);
      expect(result, testSeasonModel);
    });
  });
}

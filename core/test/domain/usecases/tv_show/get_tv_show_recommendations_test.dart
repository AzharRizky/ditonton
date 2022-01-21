import 'package:dartz/dartz.dart';
import 'package:core/src/domain/entities/tv_show.dart';
import 'package:core/src/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVShowRecommendations usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = GetTVShowRecommendations(mockTVShowRepository);
  });

  const tId = 1;
  final testTVShows = <TVShow>[];

  test('should get list of tv show recommendations from the repository',
      () async {
    // arrange
    when(mockTVShowRepository.getTVShowRecommendations(tId))
        .thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVShows));
  });
}

import 'package:dartz/dartz.dart';
import 'package:core/src/domain/usecases/tv_show/remove_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTVShow usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = RemoveWatchlistTVShow(mockTVShowRepository);
  });

  test('should remove watchlist tv show from repository', () async {
    // arrange
    when(mockTVShowRepository.removeWatchlist(testTVShowDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVShowDetail);
    // assert
    verify(mockTVShowRepository.removeWatchlist(testTVShowDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}

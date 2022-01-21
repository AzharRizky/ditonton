import 'package:dartz/dartz.dart';
import 'package:core/src/domain/usecases/tv_show/save_watchlist_tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTVShow usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = SaveWatchlistTVShow(mockTVShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTVShowRepository.saveWatchlist(testTVShowDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVShowDetail);
    // assert
    verify(mockTVShowRepository.saveWatchlist(testTVShowDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}

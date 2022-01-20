import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTVShows usecase;
  late MockTVShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTVShowRepository();
    usecase = SearchTVShows(mockTVShowRepository);
  });

  final testTVShows = <TVShow>[];
  final tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.searchTVShows(tQuery))
        .thenAnswer((_) async => Right(testTVShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(testTVShows));
  });
}

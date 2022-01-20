import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTVShows usecase;
  late MockTVShowRepository mockTVShowRpository;

  setUp(() {
    mockTVShowRpository = MockTVShowRepository();
    usecase = GetPopularTVShows(mockTVShowRpository);
  });

  final testTVShow = <TVShow>[];

  test(
      'should get list of tv shows from the repository when execute function is called',
      () async {
    // arrange
    when(mockTVShowRpository.getPopularTVShows())
        .thenAnswer((_) async => Right(testTVShow));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVShow));
  });
}

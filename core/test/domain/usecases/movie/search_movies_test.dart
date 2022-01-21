import 'package:dartz/dartz.dart';
import 'package:core/src/domain/entities/movie.dart';
import 'package:core/src/domain/usecases/movie/search_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tMovies = <Movie>[];
  const tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => const Right(tMovies));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, const Right(tMovies));
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/src/presentation/bloc/popular_movies/popular_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetPopularMovies usecase;
  late PopularMoviesBloc popularMoviesBloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    popularMoviesBloc = PopularMoviesBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(popularMoviesBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnPopularMoviesCalled().props;
    },
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => PopularMoviesLoading(),
  );

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnPopularMoviesCalled()),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesEmpty(),
    ],
  );
}

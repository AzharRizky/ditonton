import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/search/search_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockSearchMovies mockSearchMovies;
  late SearchMoviesBloc searchMoviesBloc;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(mockSearchMovies);
  });

  const testQuery = 'Squid Game';

  test('the initial state should be Initial state', () {
    expect(searchMoviesBloc.state, SearchMoviesInitial());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'should emit HasData state when data successfully fetched',
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => Right(testMovieList));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(OnQueryMoviesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchMoviesHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
      return OnQueryMoviesChange(testQuery).props;
    },
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'should emit Error state when the searched data failed to fetch',
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(OnQueryMoviesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
      return SearchMoviesLoading().props;
    },
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'should emit Empty state when the searched data is empty',
    build: () {
      when(mockSearchMovies.execute(testQuery))
          .thenAnswer((_) async => const Right([]));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(OnQueryMoviesChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchMoviesEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testQuery));
    },
  );
}

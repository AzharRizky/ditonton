import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/src/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetMovieRecommendations usecase;
  late MovieRecommendationsBloc movieRecommendationsBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetMovieRecommendations();
    movieRecommendationsBloc = MovieRecommendationsBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
  });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return OnMovieRecommendationsCalled(testId).props;
    },
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsError('Server Failure'),
    ],
    verify: (bloc) => MovieRecommendationsLoading(),
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute(testId)).thenAnswer((_) async => const Right([]));
      return movieRecommendationsBloc;
    },
    act: (bloc) => bloc.add(OnMovieRecommendationsCalled(testId)),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsEmpty(),
    ],
  );
}

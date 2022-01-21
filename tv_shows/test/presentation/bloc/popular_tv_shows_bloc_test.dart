import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/src/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetPopularTVShows usecase;
  late PopularTVShowsBloc popularTVShowsBloc;

  setUp(() {
    usecase = MockGetPopularTVShows();
    popularTVShowsBloc = PopularTVShowsBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(popularTVShowsBloc.state, PopularTVShowsEmpty());
  });

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVShowList));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTVShowsCalled()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnPopularTVShowsCalled().props;
    },
  );

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTVShowsCalled()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsError('Server Failure'),
    ],
    verify: (bloc) => PopularTVShowsLoading(),
  );

  blocTest<PopularTVShowsBloc, PopularTVShowsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return popularTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnPopularTVShowsCalled()),
    expect: () => [
      PopularTVShowsLoading(),
      PopularTVShowsEmpty(),
    ],
  );
}

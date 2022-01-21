import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/presentation/bloc/search/search_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockSearchTVShows mockSearchTVShows;
  late SearchTVShowsBloc searchTVShowsBloc;

  setUp(() {
    mockSearchTVShows = MockSearchTVShows();
    searchTVShowsBloc = SearchTVShowsBloc(mockSearchTVShows);
  });

  const testQuery = 'Money Heist';

  test('the initial state should be Initial state', () {
    expect(searchTVShowsBloc.state, SearchTVShowsInitial());
  });

  blocTest<SearchTVShowsBloc, SearchTVShowsState>(
    'should emit HasData state when data successfully fetched',
    build: () {
      when(mockSearchTVShows.execute(testQuery))
          .thenAnswer((_) async => Right(testTVShowList));
      return searchTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(testQuery));
      return OnQueryTVShowsChange(testQuery).props;
    },
  );

  blocTest<SearchTVShowsBloc, SearchTVShowsState>(
    'should emit Error state when the searched data failed to fetch',
    build: () {
      when(mockSearchTVShows.execute(testQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(testQuery));
      return SearchTVShowsLoading().props;
    },
  );

  blocTest<SearchTVShowsBloc, SearchTVShowsState>(
    'should emit Empty state when the searched data is empty',
    build: () {
      when(mockSearchTVShows.execute(testQuery))
          .thenAnswer((_) async => const Right([]));
      return searchTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnQueryTVShowsChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      SearchTVShowsEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTVShows.execute(testQuery));
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/src/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetNowPlayingTVShows usecase;
  late NowPlayingTVShowsBloc nowPlayingTVShowsBloc;

  setUp(() {
    usecase = MockGetNowPlayingTVShows();
    nowPlayingTVShowsBloc = NowPlayingTVShowsBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingTVShowsBloc.state, NowPlayingTVShowsEmpty());
  });

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => Right(testTVShowList));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTVShowsCalled()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsHasData(testTVShowList),
    ],
    verify: (bloc) {
      verify(usecase.execute());
      return OnNowPlayingTVShowsCalled().props;
    },
  );

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTVShowsCalled()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTVShowsLoading(),
  );

  blocTest<NowPlayingTVShowsBloc, NowPlayingTVShowsState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(usecase.execute()).thenAnswer((_) async => const Right([]));
      return nowPlayingTVShowsBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTVShowsCalled()),
    expect: () => [
      NowPlayingTVShowsLoading(),
      NowPlayingTVShowsEmpty(),
    ],
  );
}

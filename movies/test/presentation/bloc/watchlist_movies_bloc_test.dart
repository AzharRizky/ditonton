import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/src/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetWatchlistMovies getWatchlistMovies;
  late MockGetWatchListStatusMovie getWatchlistStatus;
  late MockRemoveWatchlistMovie removeWatchlist;
  late MockSaveWatchlistMovie saveWatchlist;
  late WatchlistMoviesBloc watchlistMoviesBloc;

  setUp(() {
    getWatchlistMovies = MockGetWatchlistMovies();
    getWatchlistStatus = MockGetWatchListStatusMovie();
    removeWatchlist = MockRemoveWatchlistMovie();
    saveWatchlist = MockSaveWatchlistMovie();
    watchlistMoviesBloc = WatchlistMoviesBloc(
      getWatchlistMovies,
      getWatchlistStatus,
      removeWatchlist,
      saveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchlistMoviesBloc.state, MovieWatchlistInitial());
  });

  group(
    'get watchlist movies test cases',
    () {
      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([testWatchlistMovie]));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistHasData(const [testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovies.execute());
          return OnFetchMovieWatchlist().props;
        },
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(getWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistError('Server Failure'),
        ],
        verify: (bloc) => MovieWatchlistLoading(),
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieWatchlist()),
        expect: () => [
          MovieWatchlistLoading(),
          MovieWatchlistEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(saveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistMoviesBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          MovieWatchlistError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}

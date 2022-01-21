import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;
  late FakeMovieRecommendationsBloc fakeMovieRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeMovieDetailBloc = FakeMovieDetailBloc();

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();

    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    fakeMovieRecommendationsBloc = FakeMovieRecommendationsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => fakeMovieDetailBloc,
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => fakeWatchlistMoviesBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (_) => fakeMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeMovieDetailBloc.close();
    fakeWatchlistMoviesBloc.close();
    fakeMovieRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(MovieWatchlistLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(MovieWatchlistHasData(testMovieList));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('movie_content')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(MovieIsAddedToWatchlist(false));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(MovieDetailHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(MovieIsAddedToWatchlist(true));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(MovieRecommendationsHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}

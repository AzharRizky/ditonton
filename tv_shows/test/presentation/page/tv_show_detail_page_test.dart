import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_shows/src/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/tv_show_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeTVShowDetailBloc fakeTVShowDetailBloc;
  late FakeWatchlistTVShowsBloc fakeWatchlistTVShowsBloc;
  late FakeTVShowRecommendationsBloc fakeTVShowRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeTVShowDetailEvent());
    registerFallbackValue(FakeTVShowDetailState());
    fakeTVShowDetailBloc = FakeTVShowDetailBloc();

    registerFallbackValue(FakeWatchlistTVShowsEvent());
    registerFallbackValue(FakeWatchlistTVShowsState());
    fakeWatchlistTVShowsBloc = FakeWatchlistTVShowsBloc();

    registerFallbackValue(FakeTVShowRecommendationsEvent());
    registerFallbackValue(FakeTVShowRecommendationsState());
    fakeTVShowRecommendationsBloc = FakeTVShowRecommendationsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TVShowDetailBloc>(
          create: (_) => fakeTVShowDetailBloc,
        ),
        BlocProvider<WatchlistTVShowsBloc>(
          create: (_) => fakeWatchlistTVShowsBloc,
        ),
        BlocProvider<TVShowRecommendationsBloc>(
          create: (_) => fakeTVShowRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTVShowDetailBloc.close();
    fakeWatchlistTVShowsBloc.close();
    fakeTVShowRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeTVShowDetailBloc.state).thenReturn(TVShowDetailLoading());
    when(() => fakeWatchlistTVShowsBloc.state)
        .thenReturn(TVShowWatchlistLoading());
    when(() => fakeTVShowRecommendationsBloc.state)
        .thenReturn(TVShowRecommendationsLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeTVShowDetailBloc.state)
        .thenReturn(TVShowDetailHasData(testTVShowDetail));
    when(() => fakeWatchlistTVShowsBloc.state)
        .thenReturn(TVShowWatchlistHasData(testTVShowList));
    when(() => fakeTVShowRecommendationsBloc.state)
        .thenReturn(TVShowRecommendationsHasData(testTVShowList));

    await tester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
    expect(find.byKey(const Key('tv_show_content')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVShowDetailBloc.state)
        .thenReturn(TVShowDetailHasData(testTVShowDetail));
    when(() => fakeWatchlistTVShowsBloc.state)
        .thenReturn(TVShowIsAddedToWatchlist(false));
    when(() => fakeTVShowRecommendationsBloc.state)
        .thenReturn(TVShowRecommendationsHasData(testTVShowList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTVShowDetailBloc.state)
        .thenReturn(TVShowDetailHasData(testTVShowDetail));
    when(() => fakeWatchlistTVShowsBloc.state)
        .thenReturn(TVShowIsAddedToWatchlist(true));
    when(() => fakeTVShowRecommendationsBloc.state)
        .thenReturn(TVShowRecommendationsHasData(testTVShowList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TVShowDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}

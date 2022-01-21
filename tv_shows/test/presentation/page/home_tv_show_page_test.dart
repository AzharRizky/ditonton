import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_shows/src/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/home_tv_show_page.dart';
import 'package:tv_shows/src/presentation/pages/popular_tv_shows_page.dart';
import 'package:tv_shows/src/presentation/pages/top_rated_tv_shows_page.dart';
import 'package:tv_shows/src/presentation/pages/tv_show_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/app_helpers.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeNowPlayingTVShowsBloc fakeNowPlayingTVShowsBloc;
  late FakePopularTVShowsBloc fakePopularTVShowBloc;
  late FakeTopRatedTVShowsBloc fakeTopRatedTVShowBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingTVShowsEvent());
    registerFallbackValue(FakeNowPlayingTVShowsState());
    fakeNowPlayingTVShowsBloc = FakeNowPlayingTVShowsBloc();

    registerFallbackValue(FakePopularTVShowsEvent());
    registerFallbackValue(FakePopularTVShowsState());
    fakePopularTVShowBloc = FakePopularTVShowsBloc();

    registerFallbackValue(FakeTopRatedTVShowsEvent());
    registerFallbackValue(FakeTopRatedTVShowsState());
    fakeTopRatedTVShowBloc = FakeTopRatedTVShowsBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingTVShowsBloc.close();
    fakePopularTVShowBloc.close();
    fakeTopRatedTVShowBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTVShowsBloc>(
          create: (context) => fakeNowPlayingTVShowsBloc,
        ),
        BlocProvider<PopularTVShowsBloc>(
          create: (context) => fakePopularTVShowBloc,
        ),
        BlocProvider<TopRatedTVShowsBloc>(
          create: (context) => fakeTopRatedTVShowBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTVShowsBloc>(
          create: (context) => fakeNowPlayingTVShowsBloc,
        ),
        BlocProvider<PopularTVShowsBloc>(
          create: (context) => fakePopularTVShowBloc,
        ),
        BlocProvider<TopRatedTVShowsBloc>(
          create: (context) => fakeTopRatedTVShowBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const HomeTVShowPage()),
    TVShowDetailPage.routeName: (context) => const FakeDestination(),
    TopRatedTVShowsPage.routeName: (context) => const FakeDestination(),
    PopularTVShowsPage.routeName: (context) => const FakeDestination(),
    '/search': (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsLoading());
    when(() => fakePopularTVShowBloc.state).thenReturn(PopularTVShowsLoading());
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeTVShowPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of now-playing-tv_shows when HasData state occurred',
      (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsHasData(testTVShowList));
    when(() => fakePopularTVShowBloc.state)
        .thenReturn(PopularTVShowsHasData(testTVShowList));
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsHasData(testTVShowList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeTVShowPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsError('error'));
    when(() => fakePopularTVShowBloc.state)
        .thenReturn(PopularTVShowsError('error'));
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeTVShowPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets(
      'Doing action "tap" on one of the Now Playing card should go to TVShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsHasData(testTVShowList));
    when(() => fakePopularTVShowBloc.state)
        .thenReturn(PopularTVShowsHasData(testTVShowList));
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsHasData(testTVShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('now_playing_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('now_playing_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Popular TVShows card should go to TVShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsHasData(testTVShowList));
    when(() => fakePopularTVShowBloc.state)
        .thenReturn(PopularTVShowsHasData(testTVShowList));
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsHasData(testTVShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('popular_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );

    await tester.tap(find.byKey(const Key('popular_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Top Rated TVShows card should go to TVShow Detail page',
      (tester) async {
    when(() => fakeNowPlayingTVShowsBloc.state)
        .thenReturn(NowPlayingTVShowsHasData(testTVShowList));
    when(() => fakePopularTVShowBloc.state)
        .thenReturn(PopularTVShowsHasData(testTVShowList));
    when(() => fakeTopRatedTVShowBloc.state)
        .thenReturn(TopRatedTVShowsHasData(testTVShowList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_tv_shows-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_tv_shows-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('popular_tv_shows-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_tv_shows-0')), findsNothing);
  });
}

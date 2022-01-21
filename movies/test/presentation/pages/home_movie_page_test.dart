import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/app_helpers.dart';
import '../../helpers/pages_test_helpers.dart';

void main() {
  late FakeNowPlayingMoviesBloc fakeNowPlayingMoviesBloc;
  late FakePopularMoviesBloc fakePopularMovieBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());
    fakeNowPlayingMoviesBloc = FakeNowPlayingMoviesBloc();

    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMovieBloc = FakePopularMoviesBloc();

    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMovieBloc = FakeTopRatedMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMoviesBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
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
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => fakeNowPlayingMoviesBloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) => _createAnotherTestableWidget(const HomeMoviePage()),
    MovieDetailPage.routeName: (context) => const FakeDestination(),
    TopRatedMoviesPage.routeName: (context) => const FakeDestination(),
    PopularMoviesPage.routeName: (context) => const FakeDestination(),
    '/search': (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of now-playing-movies when HasData state occurred',
      (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesError('error'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesError('error'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesError('error'));

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  // testWidgets('Page should display empty text when empty', (tester) async {
  //   when(() => fakeNowPlayingMoviesBloc.state)
  //       .thenReturn(NowPlayingMoviesEmpty());
  //   when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesEmpty());
  //   when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesEmpty());
  //
  //   await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));
  //
  //   expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  // });

  // testWidgets(
  //     'Doing action "tap" on see more (popular movies) should go to Popular Movies page',
  //     (tester) async {
  //   when(() => fakeNowPlayingMoviesBloc.state)
  //       .thenReturn(NowPlayingMoviesHasData(testMovieList));
  //   when(() => fakePopularMovieBloc.state)
  //       .thenReturn(PopularMoviesHasData(testMovieList));
  //   when(() => fakeTopRatedMovieBloc.state)
  //       .thenReturn(TopRatedMoviesHasData(testMovieList));
  //
  //   await tester.pumpWidget(MaterialApp(
  //     routes: routes,
  //   ));
  //
  //   expect(find.byKey(const Key('fakeHome')), findsOneWidget);
  //
  //   await tester.tap(find.byKey(const Key('fakeHome')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsOneWidget);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsOneWidget);
  //
  //   // on tap testing
  //   await tester.dragUntilVisible(
  //     find.byKey(const Key('see_more_popular_movies')),
  //     find.byType(SingleChildScrollView),
  //     const Offset(0, 200),
  //   );
  //   await tester.tap(find.byKey(const Key('see_more_popular_movies')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsNothing);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsNothing);
  // });

  // testWidgets(
  //     'Doing action "tap" on see more (top rated movies) should go to top rated movies page',
  //     (tester) async {
  //   when(() => fakeNowPlayingMoviesBloc.state)
  //       .thenReturn(NowPlayingMoviesHasData(testMovieList));
  //   when(() => fakePopularMovieBloc.state)
  //       .thenReturn(PopularMoviesHasData(testMovieList));
  //   when(() => fakeTopRatedMovieBloc.state)
  //       .thenReturn(TopRatedMoviesHasData(testMovieList));
  //
  //   await tester.pumpWidget(MaterialApp(
  //     routes: routes,
  //   ));
  //
  //   expect(find.byKey(const Key('fakeHome')), findsOneWidget);
  //
  //   await tester.tap(find.byKey(const Key('fakeHome')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsOneWidget);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsOneWidget);
  //
  //   // on tap testing
  //   await tester.dragUntilVisible(
  //     find.byKey(const Key('see_more_top_rated_movies')),
  //     find.byType(SingleChildScrollView),
  //     const Offset(0, 100),
  //   );
  //   await tester.tap(find.byKey(const Key('see_more_top_rated_movies')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsNothing);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsNothing);
  // });

  testWidgets(
      'Doing action "tap" on one of the Now Playing card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_movies-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('now_playing_movies-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('now_playing_movies-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsNothing);
    expect(find.byKey(const Key('popular_movies-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_movies-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Popular Movies card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_movies-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('popular_movies-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );

    await tester.tap(find.byKey(const Key('popular_movies-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsNothing);
    expect(find.byKey(const Key('popular_movies-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_movies-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Top Rated Movies card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHome')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHome')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('popular_movies-0')), findsOneWidget);
    expect(find.byKey(const Key('top_rated_movies-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('top_rated_movies-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('top_rated_movies-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('now_playing_movies-0')), findsNothing);
    expect(find.byKey(const Key('popular_movies-0')), findsNothing);
    expect(find.byKey(const Key('top_rated_movies-0')), findsNothing);
  });
}

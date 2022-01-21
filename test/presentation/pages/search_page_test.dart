import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/search/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_tv_shows_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakeSearchMoviesBloc fakeSearchMoviesBloc;
  late FakeSearchTVShowsBloc fakeSearchTVShowsBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
    fakeSearchMoviesBloc = FakeSearchMoviesBloc();

    registerFallbackValue(FakeSearchTVShowsEvent());
    registerFallbackValue(FakeSearchTVShowsState());
    fakeSearchTVShowsBloc = FakeSearchTVShowsBloc();
  });

  tearDown(() {
    fakeSearchMoviesBloc.close();
    fakeSearchTVShowsBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMoviesBloc>(
          create: (context) => fakeSearchMoviesBloc,
        ),
        BlocProvider<SearchTVShowsBloc>(
          create: (context) => fakeSearchTVShowsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search movies test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(SearchMoviesLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(SearchMoviesHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(SearchMoviesError('error'));

        final errorKeyFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(errorKeyFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchMoviesEmpty());

        final emptyKeyFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.movie,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyKeyFinder, findsOneWidget);
      },
    );
  });

  group('search tv shows test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(SearchTVShowsLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(SearchTVShowsHasData(testTVShowList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(SearchTVShowsError('error'));

        final errorKeyFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(errorKeyFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchTVShowsBloc.state)
            .thenReturn(SearchTVShowsEmpty());

        final emptyKeyFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_createTestableWidget(
          SearchPage(
            activeDrawerItem: DrawerItem.tvShow,
          ),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyKeyFinder, findsOneWidget);
      },
    );
  });
}

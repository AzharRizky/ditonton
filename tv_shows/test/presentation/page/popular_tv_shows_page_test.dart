import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_shows/src/presentation/bloc/popular_tv_shows/popular_tv_shows_bloc.dart';
import 'package:tv_shows/src/presentation/pages/popular_tv_shows_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/page_test_helpers.dart';

void main() {
  late FakePopularTVShowsBloc fakePopularTVShowsBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTVShowsEvent());
    registerFallbackValue(FakePopularTVShowsState());
    fakePopularTVShowsBloc = FakePopularTVShowsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVShowsBloc>(
      create: (_) => fakePopularTVShowsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakePopularTVShowsBloc.close();
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTVShowsBloc.state)
        .thenReturn(PopularTVShowsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTVShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets(
      'Page should display AppBar, ListView, and popular page when data is loaded',
      (WidgetTester tester) async {
    when(() => fakePopularTVShowsBloc.state)
        .thenReturn(PopularTVShowsHasData(testTVShowList));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVShowsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Popular TVShows'), findsOneWidget);
    expect(find.byKey(const Key('popular_page')), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => fakePopularTVShowsBloc.state)
        .thenReturn(PopularTVShowsError(errorMessage));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTVShowsPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);
  });
}

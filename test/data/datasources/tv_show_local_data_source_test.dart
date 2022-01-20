import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVShowLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TVShowLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVShowWatchlist(testTVShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTVShowTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertTVShowWatchlist(testTVShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTVShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVShowWatchlist(testTVShowTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTVShowTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeTVShowWatchlist(testTVShowTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTVShowTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Show Detail By Id', () {
    final tId = 1;

    test('should return TV Show Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getTVShowById(tId))
          .thenAnswer((_) async => testTVShowTable.toJson());
      // act
      final result = await dataSource.getTVShowById(tId);
      // assert
      expect(result, testTVShowTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getTVShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTVShowById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv shows', () {
    test('should return list of TVShowTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTVShows())
          .thenAnswer((_) async => [testTVShowTable.toJson()]);
      // act
      final result = await dataSource.getWatchlistTVShows();
      // assert
      expect(result, [testTVShowTable]);
    });
  });
}

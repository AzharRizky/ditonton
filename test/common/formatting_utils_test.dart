import 'package:ditonton/common/formatting_utils.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final genres1 = [
    Genre(id: 1, name: 'genre-1'),
  ];

  final genres2 = [
    Genre(id: 1, name: 'genre-1'),
    Genre(id: 2, name: 'genre-2'),
  ];

  group('getFormattedGenres tests', () {
    test('should maches with expected string 1', () {
      final expectedString = 'genre-1';
      final result = getFormattedGenres(genres1);

      expect(result, expectedString);
    });

    test('should maches with expected string 2', () {
      final expectedString = 'genre-1, genre-2';
      final result = getFormattedGenres(genres2);

      expect(result, expectedString);
    });
  });

  group('getFormattedDuration tests', () {
    test('should matches with expected duration 1', () {
      final expected = '23m';
      final result = getFormattedDuration(23);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      final expected = '1h 12m';
      final result = getFormattedDuration(72);

      expect(result, expected);
    });
  });

  group('getFormattedDurationFromList tests', () {
    test('should matches with expected duration 1', () {
      final expected = '20m';
      final result = getFormattedDurationFromList([20]);

      expect(result, expected);
    });

    test('should matches with expected duration 1', () {
      final expected = '20m, 1h 12m';
      final result = getFormattedDurationFromList([20, 72]);

      expect(result, expected);
    });
  });
}

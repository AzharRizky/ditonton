import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final testGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  final testGenre = Genre(
    id: testGenreModel.id,
    name: testGenreModel.name,
  );

  final testGenreMap = {
    'id': 1,
    'name': 'name',
  };

  test('should be a subclass of Genre entity', () async {
    final result = testGenreModel.toEntity();
    expect(result, testGenre);
  });

  test('should be a map of genre', () async {
    final result = testGenreModel.toJson();
    expect(result, testGenreMap);
  });

  test('should be a GenreModel entity instance', () async {
    final result = GenreModel.fromJson(testGenreMap);
    expect(result, testGenreModel);
  });
}

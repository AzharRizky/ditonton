// Mocks generated by Mockito 5.0.17 from annotations
// in ditonton/test/helpers/bloc_test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:core/src/common/failure.dart' as _i7;
import 'package:core/src/domain/entities/movie.dart' as _i8;
import 'package:core/src/domain/entities/tv_show.dart' as _i10;
import 'package:core/src/domain/repositories/movie_repository.dart' as _i2;
import 'package:core/src/domain/repositories/tv_show_repository.dart' as _i4;
import 'package:core/src/domain/usecases/movie/search_movies.dart' as _i5;
import 'package:core/src/domain/usecases/tv_show/search_tv_shows.dart' as _i9;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeTVShowRepository_2 extends _i1.Fake implements _i4.TVShowRepository {
}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends _i1.Mock implements _i5.SearchMovies {
  MockSearchMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Movie>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i8.Movie>>>);
}

/// A class which mocks [SearchTVShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchTVShows extends _i1.Mock implements _i9.SearchTVShows {
  MockSearchTVShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TVShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTVShowRepository_2()) as _i4.TVShowRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.TVShow>>> execute(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i10.TVShow>>>.value(
              _FakeEither_1<_i7.Failure, List<_i10.TVShow>>())) as _i6
          .Future<_i3.Either<_i7.Failure, List<_i10.TVShow>>>);
}
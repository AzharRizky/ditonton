import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_shows/src/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helpers.mocks.dart';

void main() {
  late MockGetTVShowDetail usecase;
  late TVShowDetailBloc tvShowDetailBloc;

  const testId = 1;

  setUp(() {
    usecase = MockGetTVShowDetail();
    tvShowDetailBloc = TVShowDetailBloc(usecase);
  });

  test('the initial state should be empty', () {
    expect(tvShowDetailBloc.state, TVShowDetailEmpty());
  });

  blocTest<TVShowDetailBloc, TVShowDetailState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => Right(testTVShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTVShowDetailCalled(testId)),
    expect: () => [
      TVShowDetailLoading(),
      TVShowDetailHasData(testTVShowDetail),
    ],
    verify: (bloc) {
      verify(usecase.execute(testId));
      return OnTVShowDetailCalled(testId).props;
    },
  );

  blocTest<TVShowDetailBloc, TVShowDetailState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(usecase.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnTVShowDetailCalled(testId)),
    expect: () => [
      TVShowDetailLoading(),
      TVShowDetailError('Server Failure'),
    ],
    verify: (bloc) => TVShowDetailLoading(),
  );
}

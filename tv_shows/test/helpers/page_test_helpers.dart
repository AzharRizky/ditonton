import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_shows/tv_shows.dart';

/// fake now playing tv shows bloc
class FakeNowPlayingTVShowsEvent extends Fake
    implements NowPlayingTVShowsEvent {}

class FakeNowPlayingTVShowsState extends Fake
    implements NowPlayingTVShowsState {}

class FakeNowPlayingTVShowsBloc
    extends MockBloc<NowPlayingTVShowsEvent, NowPlayingTVShowsState>
    implements NowPlayingTVShowsBloc {}

/// fake popular tv shows bloc
class FakePopularTVShowsEvent extends Fake implements PopularTVShowsEvent {}

class FakePopularTVShowsState extends Fake implements PopularTVShowsState {}

class FakePopularTVShowsBloc
    extends MockBloc<PopularTVShowsEvent, PopularTVShowsState>
    implements PopularTVShowsBloc {}

/// fake top rated tv shows bloc
class FakeTopRatedTVShowsEvent extends Fake implements TopRatedTVShowsEvent {}

class FakeTopRatedTVShowsState extends Fake implements TopRatedTVShowsState {}

class FakeTopRatedTVShowsBloc
    extends MockBloc<TopRatedTVShowsEvent, TopRatedTVShowsState>
    implements TopRatedTVShowsBloc {}

/// fake detail tv show bloc
class FakeTVShowDetailEvent extends Fake implements TVShowDetailEvent {}

class FakeTVShowDetailState extends Fake implements TVShowDetailState {}

class FakeTVShowDetailBloc
    extends MockBloc<TVShowDetailEvent, TVShowDetailState>
    implements TVShowDetailBloc {}

/// fake tv show recommendations bloc
class FakeTVShowRecommendationsEvent extends Fake
    implements TVShowRecommendationsEvent {}

class FakeTVShowRecommendationsState extends Fake
    implements TVShowRecommendationsState {}

class FakeTVShowRecommendationsBloc
    extends MockBloc<TVShowRecommendationsEvent, TVShowRecommendationsState>
    implements TVShowRecommendationsBloc {}

/// fake watchlist tv shows bloc
class FakeWatchlistTVShowsEvent extends Fake implements WatchlistTVShowsEvent {}

class FakeWatchlistTVShowsState extends Fake implements WatchlistTVShowsState {}

class FakeWatchlistTVShowsBloc
    extends MockBloc<WatchlistTVShowsEvent, WatchlistTVShowsState>
    implements WatchlistTVShowsBloc {}

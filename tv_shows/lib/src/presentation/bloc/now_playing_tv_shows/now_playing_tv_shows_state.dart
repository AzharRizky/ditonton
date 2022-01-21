part of 'now_playing_tv_shows_bloc.dart';

@immutable
abstract class NowPlayingTVShowsState extends Equatable {}

class NowPlayingTVShowsEmpty extends NowPlayingTVShowsState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVShowsLoading extends NowPlayingTVShowsState {
  @override
  List<Object> get props => [];
}

class NowPlayingTVShowsError extends NowPlayingTVShowsState {
  final String message;

  NowPlayingTVShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTVShowsHasData extends NowPlayingTVShowsState {
  final List<TVShow> result;

  NowPlayingTVShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

part of 'search_tv_shows_bloc.dart';

@immutable
abstract class SearchTVShowsEvent extends Equatable {}

class OnQueryTVShowsChange extends SearchTVShowsEvent {
  final String query;

  OnQueryTVShowsChange(this.query);

  @override
  List<Object> get props => [query];
}

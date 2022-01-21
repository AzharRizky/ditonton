part of 'tv_show_detail_bloc.dart';

@immutable
abstract class TVShowDetailEvent extends Equatable {}

class OnTVShowDetailCalled extends TVShowDetailEvent {
  final int id;

  OnTVShowDetailCalled(this.id);

  @override
  List<Object> get props => [id];
}

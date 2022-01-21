part of 'tv_show_detail_bloc.dart';

@immutable
abstract class TVShowDetailState extends Equatable {}

class TVShowDetailEmpty extends TVShowDetailState {
  @override
  List<Object> get props => [];
}

class TVShowDetailLoading extends TVShowDetailState {
  @override
  List<Object> get props => [];
}

class TVShowDetailError extends TVShowDetailState {
  final String message;

  TVShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TVShowDetailHasData extends TVShowDetailState {
  final TVShowDetail result;

  TVShowDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

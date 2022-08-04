part of 'commnet_list_bloc.dart';

abstract class CommnetListState extends Equatable {
  const CommnetListState();

  @override
  List<Object> get props => [];
}

class CommnetListLoading extends CommnetListState {}

class CommnetListSuccess extends CommnetListState {
  final List<CommnetEntiry> commnets;

   CommnetListSuccess(this.commnets);

  @override
  // TODO: implement props
  List<Object> get props => [commnets];
}

class CommentListError extends CommnetListState {
  final AppException exception;

  const CommentListError(this.exception);

  @override
  // TODO: implement props
  List<Object> get props => [exception];
}




part of 'commnet_list_bloc.dart';

abstract class CommnetListEvent extends Equatable {
  const CommnetListEvent();

  @override
  List<Object> get props => [];
}

class CommentListStarted extends CommnetListEvent {}




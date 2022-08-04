import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/repo/commnet_repository.dart';
import 'package:nike_store/ui/product/bloc/product_bloc.dart';

part 'commnet_list_event.dart';
part 'commnet_list_state.dart';

class CommnetListBloc extends Bloc<CommnetListEvent, CommnetListState> {
  final ICommentRepository commnetRepository;
  final int productId;
  CommnetListBloc({required this.commnetRepository, required this.productId})
      : super(CommnetListLoading()) {
    on<CommnetListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommnetListLoading());

        try {
          final comments =
              await commnetRepository.getAllComment(productId: productId);
          emit(CommnetListSuccess(comments));
        } catch (e) {
          emit(CommentListError(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      } 
    });
  }
}

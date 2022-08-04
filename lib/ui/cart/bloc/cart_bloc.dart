import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/data/response/cart_response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>((event, emit) async {
      if (event is CartStarted) {
        try {
          emit(CartLoading());
          final result = await cartRepository.getAll();
          emit(CartSuccess(result));
        } catch (e) {
          emit(CartError(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      }
    });
  }
}

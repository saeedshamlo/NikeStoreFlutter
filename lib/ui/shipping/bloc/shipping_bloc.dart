import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/repo/order_repository.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, ShippingState> {
  final IOrderRepository repository;
  ShippingBloc(this.repository) : super(ShippingInitial()) {
    on<ShippingEvent>((event, emit) async {
      if (event is ShippingCreateOrder) {
        try {
          emit(ShippingLoading());
          final result = await repository.create(event.params);
          emit(ShippingSuccess(result));
        } catch (e) {
          if (e is DioError) {
            emit(ShippingError(
                AppException(message: e.response?.data['message'])));
          }
        }
      }
    });
  }
}

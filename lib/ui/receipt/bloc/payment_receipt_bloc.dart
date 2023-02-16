import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/payment_receipt.dart';
import 'package:nike_store/data/repo/order_repository.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc
    extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository repository;
  PaymentReceiptBloc(this.repository) : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptStarted) {
        try {
          emit(PaymentReceiptLoading());
          final result = await repository.getPaymentReceipt(event.orderId);
          emit(PaymentReceiptSuccess(result));
        } catch (e) {
          emit(PaymentReceiptFailure(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      }
    });
  }
}

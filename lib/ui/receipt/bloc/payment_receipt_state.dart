part of 'payment_receipt_bloc.dart';

@immutable
abstract class PaymentReceiptState {}

class PaymentReceiptLoading extends PaymentReceiptState {}
class PaymentReceiptSuccess extends PaymentReceiptState{
  final PaymentReceiptData paymentReceiptData;

  PaymentReceiptSuccess(this.paymentReceiptData);
}

class PaymentReceiptFailure extends PaymentReceiptState{
  
   final AppException exception;

  PaymentReceiptFailure(this.exception);
 
}

part of 'payment_receipt_bloc.dart';

@immutable
abstract class PaymentReceiptEvent {}



class PaymentReceiptStarted extends PaymentReceiptEvent{
    final int orderId;

  PaymentReceiptStarted(this.orderId);
  

  
}
class PaymentReceiptData {
  final bool purchaseSuccess;
  final int payablePrice;
  final String payamentStatus;

  PaymentReceiptData.fromJson(Map<String, dynamic> json)
      : purchaseSuccess = json['purchase_success'],
        payablePrice = json['payable_price'],
        payamentStatus = json['payment_status'];
}

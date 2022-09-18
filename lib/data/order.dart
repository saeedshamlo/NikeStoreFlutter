class CreateOrderReuslt {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderReuslt(this.orderId, this.bankGatewayUrl);
  CreateOrderReuslt.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}

class CreateOrderParams {
  final String firtsName;
  final String lastName;
  final String phoneNumber;
  final String postalCode;
  final String address;
  final PaymentMethod paymentMethod;

  CreateOrderParams(this.firtsName, this.lastName, this.phoneNumber,
      this.postalCode, this.address, this.paymentMethod);
}

enum PaymentMethod { online, cashOnDelivery }

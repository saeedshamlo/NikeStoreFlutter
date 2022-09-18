import 'package:dio/dio.dart';
import 'package:nike_store/data/order.dart';

abstract class IOrderDataSource {
  Future<CreateOrderReuslt> create(CreateOrderParams params);
}

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);
  @override
  Future<CreateOrderReuslt> create(CreateOrderParams params) async{
    final response = await httpClient.post('order/submit', data: {
      'firstName': params.firtsName,
      'lastName': params.lastName,
      'mobile': params.phoneNumber,
      'postal_code': params.postalCode,
      'address': params.address,
      'payment_method': params.paymentMethod == PaymentMethod.online
          ? 'online'
          : 'cash_on_delivery'
    });

    return CreateOrderReuslt.fromJson(response.data);
  }
}

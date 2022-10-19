import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/dataSource/order_data_source.dart';
import 'package:nike_store/data/order.dart';

abstract class IOrderRepository extends IOrderDataSource {}

final OrderRepositry orderRepositry =
    OrderRepositry(OrderRemoteDataSource(httpClient));

class OrderRepositry implements IOrderRepository {
  final IOrderDataSource dataSource;

  OrderRepositry(this.dataSource);
  @override
  Future<CreateOrderReuslt> create(CreateOrderParams params) {
    return dataSource.create(params);
  }
}

import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/add_to_cart_response.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:nike_store/data/dataSource/cart_data_source.dart';
import 'package:nike_store/data/response/cart_response.dart';

final CartRepository cartRepository =
    CartRepository(CartRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId,int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getAll();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);

  @override
  Future<AddToCartResponse> add(int productId) => dataSource.add(productId);

  @override
  Future<AddToCartResponse> changeCount(int cartItemId,int count) {
    return dataSource.changeCount(cartItemId, count);
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) {
   return dataSource.delete(cartItemId);
  }

  @override
  Future<CartResponse> getAll() {
    return dataSource.getAll();
  }
}

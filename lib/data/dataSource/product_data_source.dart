import 'package:dio/dio.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/common/response_validator.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/response/add_comment_response.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAllProduct(int sort);
  Future<List<ProductEntity>> searchProduct(String search);
  Future<AddCommentReposne> addCommnet(
      {required int productId, required String content, required String title});
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClicent;

  ProductRemoteDataSource(this.httpClicent);
  @override
  Future<List<ProductEntity>> getAllProduct(int sort) async {
    final response = await httpClicent.get('product/list?sort=$sort');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> searchProduct(String search) async {
    final response = await httpClicent.get('product/search?q=$search');
    validateResponse(response);
    final products = <ProductEntity>[];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromJson(element));
    });
    return products;
  }

  @override
  Future<AddCommentReposne> addCommnet(
      {required int productId,
      required String content,
      required String title}) async {
    final response = await httpClient.post('comment/add',
        data: {"productId": productId, "content": content, "title": title});

    validateResponse(response);
    return AddCommentReposne.fromJson(response.data);
  }
}

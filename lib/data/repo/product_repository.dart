import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/dataSource/product_data_source.dart';
import 'package:nike_store/data/product.dart';


final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepository {
  Future<List<ProductEntity>> getAllProduct(int sort);
  Future<List<ProductEntity>> searchProduct(String search);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductEntity>> getAllProduct(int sort) =>
      dataSource.getAllProduct(sort);

  @override
  Future<List<ProductEntity>> searchProduct(String search) =>
      dataSource.searchProduct(search);
}

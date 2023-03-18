import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final IProductRepository productRepository;
  ProductListBloc(this.productRepository) : super(ProductListLoading()) {
    on<ProductListEvent>((event, emit) async {
      if (event is ProductListStarted) {
        emit(ProductListLoading());
        try {
          final products = await productRepository.getAllProduct(event.sort);
          emit(ProductListSuccess(products, event.sort, ProductSort.names));
          
        } catch (e) {
          emit(ProductListError(e is DioError
              ? AppException(message: e.response?.data['message'])
              : AppException()));
        }
      }
    });
  }
}

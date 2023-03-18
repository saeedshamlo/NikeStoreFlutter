part of 'product_list_bloc.dart';

@immutable
abstract class ProductListState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<ProductEntity> products;
  final int sort;

  final List<String> sortNames;

  ProductListSuccess(this.products, this.sort, this.sortNames);

  @override
  // TODO: implement props

      List<Object?> get props => [sort, sortNames, products];

}

class ProductListError extends ProductListState {
  final AppException exception;

  ProductListError(this.exception);
  @override
  List<Object> get props => [exception];
}

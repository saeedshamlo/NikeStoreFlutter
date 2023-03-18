part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductListStarted extends ProductListEvent {
  final int sort;

  ProductListStarted(this.sort);

  @override
  // TODO: implement props
  List<Object?> get props => [sort];
}

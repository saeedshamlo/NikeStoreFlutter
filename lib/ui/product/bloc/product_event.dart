part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class CartAddButtonClick extends ProductEvent{
  final int productId;

  CartAddButtonClick(this.productId);
}
class CommentAddButtonClick extends ProductEvent {
  final int productId;
  final String content;
  final String title;

  CommentAddButtonClick(this.productId, this.content, this.title);
}

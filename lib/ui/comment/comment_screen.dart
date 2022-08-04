import 'package:flutter/cupertino.dart';
import 'package:nike_store/ui/product/commnet/comment_list.dart';

class CommentScreen extends StatelessWidget {
  final int productId;

  const CommentScreen({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return CommentList(productId: productId);
  }
}

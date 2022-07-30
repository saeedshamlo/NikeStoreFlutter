import 'package:dio/dio.dart';
import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/common/response_validator.dart';

abstract class ICommentDataSource {
  Future<List<CommnetEntiry>> getAllComment({required int productId});
}

class CommnetDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommnetDataSource(this.httpClient);

  @override
  Future<List<CommnetEntiry>> getAllComment({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);

    final List<CommnetEntiry> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommnetEntiry.fromJson(element));
    });

    return comments;
  }
}

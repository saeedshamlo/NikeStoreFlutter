import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/comment.dart';
import 'package:nike_store/data/dataSource/commnet_data_source.dart';

final commnetRepository = CommnetRepository(CommnetDataSource(httpClient));

abstract class ICommentRepository {
  Future<List<CommnetEntiry>> getAllComment({required int productId});
}

class CommnetRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommnetRepository(this.dataSource);
  @override
  Future<List<CommnetEntiry>> getAllComment({required int productId}) =>
      dataSource.getAllComment(productId: productId);
}

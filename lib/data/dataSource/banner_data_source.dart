import 'package:dio/dio.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/common/response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getBanners();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio htttpClient;

  BannerRemoteDataSource(this.htttpClient);
  @override
  Future<List<BannerEntity>> getBanners() async {
    final response = await htttpClient.get('banner/slider');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((element) {
      banners.add(BannerEntity.fromJson(element));
    });
    return banners;
  }
}

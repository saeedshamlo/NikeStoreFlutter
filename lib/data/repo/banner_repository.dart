import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/dataSource/banner_data_source.dart';

abstract class IBannerRepository {
  Future<List<BannerEntity>> getBanners();
}

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient));

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);
  @override
  Future<List<BannerEntity>> getBanners() => dataSource.getBanners();
}

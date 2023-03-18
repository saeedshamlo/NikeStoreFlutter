import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/exception.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/banner.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/banner_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/ui/home/bloc/home_bloc.dart';
import 'package:nike_store/ui/list/list.dart';
import 'package:nike_store/ui/product/product.dart';
import 'package:nike_store/ui/search/search_screen.dart';
import 'package:nike_store/ui/widget/error.dart';
import 'package:nike_store/ui/widget/image.dart';
import 'package:nike_store/ui/widget/slider.dart';
import 'package:rive/rive.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RiveAnimationController likeAnimationController;

  @override
  void initState() {
    likeAnimationController = OneShotAnimation("like", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  itemCount: 5,
                  physics: defultScrollPhysics,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      case 1:
                       return SizedBox(height: 16,);
                      case 2:
                        return BannerSlider(banners: state.banners);
                      case 3:
                        return HorizontalProductList(
                          title: 'جدیدترین',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductListScreen(sort: ProductSort.latest),
                            ));
                          },
                          products: state.latestProducts,
                        );
                      case 4:
                        return HorizontalProductList(
                          title: 'محبوب ترین',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductListScreen(sort: ProductSort.popular),
                            ));
                          },
                          products: state.popularProducts,
                        );
                      default:
                        return Container(
                          color: Colors.amber,
                        );
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(
                    child: SizedBox(
                        width: 64,
                        height: 64,
                        child: RiveAnimation.asset('assets/riv/loading.riv')));
                // return Shimmer.fromColors(
                //   child: Container(
                //     width: 100,
                //     height: 100,
                //     color: Colors.red,
                //   ),
                //   baseColor: Colors.grey.shade300,
                //   highlightColor: Colors.grey.shade100,
                // );
              } else if (state is HomeError) {
                return AppErrorWidget(
                  appException: state.exception,
                  onTryAgainClick: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}

class HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const HorizontalProductList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(onPressed: onTap, child: const Text('مشاهد همه')),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              physics: defultScrollPhysics,
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 8),
              itemBuilder: ((context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  borderRadius: BorderRadius.circular(16),
                );
              })),
        )
      ],
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 50,
        child: Stack(
          children: [
            TextField(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SerachScreen(),
              )),
              style: defultTextStyle.copyWith(fontWeight: FontWeight.bold),
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                  hintText: "جستجو",
                  hintStyle:
                      defultTextStyle.copyWith(fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(CupertinoIcons.search),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

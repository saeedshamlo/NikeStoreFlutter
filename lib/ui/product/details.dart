import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/product/commnet/comment_list.dart';
import 'package:nike_store/ui/widget/image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductDetailsScreen({super.key, required this.productEntity});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: FloatingActionButton.extended(
                splashColor: Colors.blue,
                onPressed: () {},
                label: Text(
                  'افزودن به سبد خرید',
                  style: defultTextStyle.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
        body: CustomScrollView(
          physics: defultScrollPhysics,
          slivers: [
            SliverAppBar(
              stretchTriggerOffset: 50,
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              flexibleSpace: ImageLoadingService(imageUrl: productEntity.image),
              foregroundColor: LightThemeColors.primatyTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          productEntity.title,
                          style: Theme.of(context).textTheme.headline6,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              pricalbe(productEntity.previousPrice!),
                              style: Theme.of(context).textTheme.caption!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              pricalbe(productEntity.price),
                              style: defultTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                        'این محصول بسیار زیبا و راحت است و من در استفاده از آن بیسار راضی هستم . باشد که از محصول ایرانی بیشتر حمایت شود'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کابران',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        TextButton(
                            onPressed: () {}, child: const Text('ثبت نظر'))
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
            CommentList(productId: productEntity.id,)
          ],
        ),
      ),
    );
  }
}

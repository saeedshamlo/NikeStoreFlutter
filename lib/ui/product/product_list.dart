import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/ui/product/details.dart';
import 'package:nike_store/ui/widget/image.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.product,
    required this.borderRadius,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productEntity: product,
              ),
            ));
          },
          borderRadius: borderRadius,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
              child: Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ImageLoadingService(
                          imageUrl: product.image,
                          radius: borderRadius,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            CupertinoIcons.heart,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 16),
                          ),
                          Text(
                            'موجود در انبار نایک استور',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 8),
                            child: Text.rich(
                              
                              TextSpan(
                             children: [

                              TextSpan(
                                text: product.price.withPrice,
                                style: defultTextStyle.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: 'تومان')
                            ]),
                            textAlign: TextAlign.left,),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/ui/widget/image.dart';

class ProductItemList extends StatelessWidget {
  final ProductEntity product;

  const ProductItemList({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                SizedBox(
                  width: 176,
                  height: 189,
                  child: ImageLoadingService(
                    imageUrl: product.image,
                    radius: BorderRadius.circular(8),
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
          ),
          Column(
            children: [
              Text(product.title),
              Text(product.title),
              Text(product.price.withPriceLable)
            ],
          )
        ],
      ),
    );
  }
}

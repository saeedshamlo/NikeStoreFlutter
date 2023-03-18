import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/ui/product/details.dart';
import 'package:nike_store/ui/widget/image.dart';
import 'package:rive/rive.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWitdth = 176,
    this.itemHeight = 189,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;
  final double itemWitdth;
  final double itemHeight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late RiveAnimationController likeAnimationController;

  @override
  void initState() {
    likeAnimationController = OneShotAnimation("Like", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                productEntity: widget.product,
              ),
            ));
          },
          borderRadius: widget.borderRadius,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: widget.borderRadius,
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: widget.itemWitdth,
                            height: widget.itemHeight,
                            child: ImageLoadingService(
                              imageUrl: widget.product.image,
                              radius: widget.borderRadius,
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: 
                            InkWell(
                              onTap: () {
                                setState(() {
                                   likeAnimationController.isActive = true;
                                });
                              },
                              child: Container(
                                  width: 32,
                                  height: 32,
                                
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  child: 
                                  Icon(CupertinoIcons.heart,size: 20,)
                                  // RiveAnimation.asset(
                                  //   'assets/riv/like.riv',
                                  //   controllers: [likeAnimationController],
                                  // )
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 176,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: Text(
                          widget.product.title.substring(0, 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        widget.product.previousPrice!.withPriceLable,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        widget.product.price.withPriceLable,
                        style: defultTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

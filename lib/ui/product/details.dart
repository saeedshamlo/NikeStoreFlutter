import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/product.dart';
import 'package:nike_store/data/repo/cart_repository.dart';
import 'package:nike_store/data/repo/product_repository.dart';
import 'package:nike_store/main.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/comment/comment_screen.dart';
import 'package:nike_store/ui/product/bloc/product_bloc.dart';
import 'package:nike_store/ui/product/commnet/bloc/commnet_list_bloc.dart';
import 'package:nike_store/ui/product/commnet/comment_list.dart';
import 'package:nike_store/ui/widget/image.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity productEntity;

  const ProductDetailsScreen({super.key, required this.productEntity});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  StreamSubscription<ProductState>? stateSubscription = null;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    scaffoldMessengerKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository, productRepository);
          stateSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            } else if (state is ProductAddToCartError) {
              scaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(content: Text(state.exception.message!)));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  return FloatingActionButton.extended(
                      splashColor: Colors.blue,
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(CartAddButtonClick(widget.productEntity.id));
                      },
                      label: state is ProductAddToCartButtonLoading
                          ? CupertinoActivityIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'افزودن به سبد خرید',
                              style: defultTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ));
                })),
            body: CustomScrollView(
              physics: defultScrollPhysics,
              slivers: [
                SliverAppBar(
                  stretchTriggerOffset: 50,
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace:
                      ImageLoadingService(imageUrl: widget.productEntity.image),
                  foregroundColor: LightThemeColors.primatyTextColor,
                  actions: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart))
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
                              widget.productEntity.title,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.productEntity.previousPrice!
                                      .withPriceLable,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(
                                  widget.productEntity.price.withPriceLable,
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
                            'این محصول بسیار زیبا و راحت است و من در استفاده از آن بسیار راضی هستم . باشد که از محصول ایرانی بیشتر حمایت شود'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کابران',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextButton(
                                onPressed: () {
                                  // showAddCommentDialog(context);
                                  // Navigator.of(context,rootNavigator: true).push(
                                  //   MaterialPageRoute(builder: (context) => CommentScreen(productId: widget.productEntity.id),));
                                },
                                child: const Text('همه'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(
                  productId: widget.productEntity.id,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddCommentDialog(BuildContext context) {
    return showModalBottomSheet(
        useRootNavigator: true,
        elevation: 24,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16))),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, right: 16, left: 16, bottom: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'اضافه کردن نظر',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(label: Text('عنوان')),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        textAlignVertical: TextAlignVertical.top,
                        minLines: 5,
                        maxLines: 10,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(label: Text('کامنت')),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<ProductBloc, ProductState>(
                          builder: (context, state) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          child: ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: () {
                                BlocProvider.of<ProductBloc>(context).add(
                                    CommentAddButtonClick(
                                        widget.productEntity.id,
                                        "سلام",
                                        "خسته نباشید"));
                              },
                              child: Text(
                                'ثبت',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

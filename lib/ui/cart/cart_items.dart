import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/widget/image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.data,
    required this.onDeleteButttonClick,
    required this.onIncButttonClick,
    required this.onDecButttonClick,
  }) : super(key: key);

  final CartItemEntity data;

  final GestureTapCallback onDeleteButttonClick;
  final GestureTapCallback onIncButttonClick;
  final GestureTapCallback onDecButttonClick;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ImageLoadingService(
                    imageUrl: data.product.image,
                    radius: BorderRadius.circular(12),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.product.title,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('تعداد'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: onIncButttonClick,
                            icon: Icon(CupertinoIcons.plus_square)),
                        data.changeCountLoading
                            ? CupertinoActivityIndicator(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )
                            : Text(
                                data.count.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              ),
                        IconButton(
                            onPressed: onDecButttonClick,
                            icon: Icon(CupertinoIcons.minus_square)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.product.previousPrice != null
                          ? data.product.previousPrice!.withPriceLable
                          : '',
                      style: TextStyle(decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                      color: LightThemeColors.seccondryTextColor),
                    ),
                    Text(data.product.price.withPriceLable)
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          data.deleteButtonLoading
              ? SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: TextButton(
                
                    onPressed: onDeleteButttonClick,
                    child: Text('حذف از سبد خرید')),
              )
        ],
      ),
    );
  }
}

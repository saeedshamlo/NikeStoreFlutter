import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/cart_item.dart';
import 'package:nike_store/ui/widget/image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.data,
     required this.onDeleteButttonClick,
  }) : super(key: key);

  final CartItemEntity data;

  final GestureTapCallback onDeleteButttonClick;
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
                    radius: BorderRadius.circular(4),
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
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.plus_square)),
                        Text(
                          data.count.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.minus_square)),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pricalbe(data.product.previousPrice),
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                    Text(pricalbe(data.product.price))
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          data.deleteButtonLoading
              ? SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : TextButton(onPressed: onDeleteButttonClick, child: Text('حذف از سبد خرید'))
        ],
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/common/utils.dart';

class PriceInfo extends StatelessWidget {
  final int payblePrice;
  final int totalPrice;
  final int shippingCost;

  const PriceInfo(
      {super.key,
      required this.payblePrice,
      required this.totalPrice,
      required this.shippingCost});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            'جزییات خرید',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.09))
              ]),
          child: Column(
            children: [
              priceItem('مبلغ کل خرید', totalPrice, context,14),
              Divider(),
              priceItem('هزینه ارسال', shippingCost, context,14),
              Divider(),
              priceItem('مبلغ قابل پرداخت', payblePrice, context,18),
            ],
          ),
        ),
      ],
    );
  }

  Padding priceItem(String lable, int value, BuildContext context,double fontSize) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(lable),
          value>0?
          RichText(
              text: TextSpan(
                  text: value.sepataterByComma,
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize),
                  children: [
                TextSpan(
                  text: ' تومان',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                )
              ])):Text('رایگان')
        ],
      ),
    );
  }
}

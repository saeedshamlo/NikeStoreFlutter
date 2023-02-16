import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/data/order.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/ui/cart/price_info.dart';
import 'package:nike_store/ui/payment_webview.dart';
import 'package:nike_store/ui/receipt/payment_receipt.dart';
import 'package:nike_store/ui/shipping/bloc/shipping_bloc.dart';

class ShippingScreen extends StatefulWidget {
  final int payblePrice;
  final int totalPrice;
  final int shippingCost;

  ShippingScreen(
      {super.key,
      required this.payblePrice,
      required this.totalPrice,
      required this.shippingCost});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final style = TextStyle(fontFamily: 'YekanBakh');

  final TextEditingController firstNameControler =
      TextEditingController(text: 'سعید');

  final TextEditingController lastNameControler =
      TextEditingController(text: 'شاملو');

  final TextEditingController phoneNumberControler =
      TextEditingController(text: '09109882889');

  final TextEditingController postalCodeControler =
      TextEditingController(text: '3351167566');

  final TextEditingController addressControler =
      TextEditingController(text: 'تهران شهریار امیریه خیابان فلسطین');

  StreamSubscription? subscription;
  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('انتخاب تحویل گیرنده و شیوه پرداخت'),
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepositry);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(event.exception.message!)));
            } else if (event is ShippingSuccess) {
              if (event.reuslt.bankGatewayUrl.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(
                            banckGatewayeUrl: event.reuslt.bankGatewayUrl)));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PaymentReceiptScreen(orderId: event.reuslt.orderId)));
              }
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                style: style,
                controller: firstNameControler,
                decoration: InputDecoration(
                  label: Text(
                    'نام',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                style: style,
                controller: lastNameControler,
                decoration: InputDecoration(
                  label: Text(
                    'نام خانوادگی',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                style: style,
                controller: phoneNumberControler,
                decoration: InputDecoration(
                  label: Text(
                    'شماره تماس',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                style: style,
                controller: postalCodeControler,
                decoration: InputDecoration(
                  label: Text(
                    'کد پستی',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: addressControler,
                style: style,
                decoration: InputDecoration(
                  label: Text(
                    'آدرس',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              PriceInfo(
                  payblePrice: widget.payblePrice,
                  totalPrice: widget.totalPrice,
                  shippingCost: widget.shippingCost),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<ShippingBloc, ShippingState>(
                    builder: (context, state) {
                      return State is ShippingLoading
                          ? Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed: () {
                                        BlocProvider.of<ShippingBloc>(context)
                                            .add(ShippingCreateOrder(
                                                CreateOrderParams(
                                                    firstNameControler.text,
                                                    lastNameControler.text,
                                                    phoneNumberControler.text,
                                                    postalCodeControler.text,
                                                    addressControler.text,
                                                    PaymentMethod
                                                        .cashOnDelivery)));
                                      },
                                      child: Text('پرداخت در محل')),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<ShippingBloc>(context)
                                              .add(ShippingCreateOrder(
                                                  CreateOrderParams(
                                                      firstNameControler.text,
                                                      lastNameControler.text,
                                                      phoneNumberControler.text,
                                                      postalCodeControler.text,
                                                      addressControler.text,
                                                      PaymentMethod.online)));
                                        },
                                        child: Text('پرداخت اینترنتی'))),
                              ],
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

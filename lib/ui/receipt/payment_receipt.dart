import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/common/utils.dart';
import 'package:nike_store/data/repo/order_repository.dart';
import 'package:nike_store/theme.dart';
import 'package:nike_store/ui/receipt/bloc/payment_receipt_bloc.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;

  const PaymentReceiptScreen({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('رسید پرداخت'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: BlocProvider<PaymentReceiptBloc>(
          create: (context) => PaymentReceiptBloc(orderRepositry)..add(PaymentReceiptStarted(orderId)),
          child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
            builder: (context, state) {
              if (state is PaymentReceiptSuccess) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SvgPicture.asset(
                        'assets/img/buy_success.svg',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: themeData.dividerColor, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Text(
                           state.paymentReceiptData.purchaseSuccess? 'سفارش با موفیقت ثبت شد':'سفارش ثبت نشد',
                            style: themeData.textTheme.headline6!
                                .apply(color: themeData.colorScheme.primary),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'وضعیت سفارش',
                                style: TextStyle(
                                    color: LightThemeColors.seccondryTextColor),
                              ),
                              Text(
                                state.paymentReceiptData.payamentStatus,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                          Divider(
                            height: 32,
                            thickness: 1,
                            color: themeData.dividerColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'مبلغ',
                                style: TextStyle(
                                    color: LightThemeColors.seccondryTextColor),
                              ),
                              Text(
                                 state.paymentReceiptData.payablePrice.withPriceLable,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          OutlinedButton(
                              onPressed: () {}, child: Text('سوابق سفارش')),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                },
                                child: Text('بازگشت به صفحه اصلی')),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else if (state is PaymentReceiptFailure) {
                return Center(child: Text(state.exception.message));
              } else if (state is PaymentReceiptLoading) {
                return Center(
                  child: CupertinoActivityIndicator(),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_store/theme.dart';

class PaymentReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('رسید پرداخت'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          
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
                  border: Border.all(color: themeData.dividerColor, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text(
                    'پرداخت با موفیقت انجام شد',
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
                        style:
                            TextStyle(color: LightThemeColors.seccondryTextColor),
                      ),
                      Text(
                        'پرداخت شده',
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
                        style:
                            TextStyle(color: LightThemeColors.seccondryTextColor),
                      ),
                      Text(
                        '245000 تومان',
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
                  OutlinedButton(onPressed: () {}, child: Text('سوابق سفارش')),
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
        ),
      ),
    );
  }
}

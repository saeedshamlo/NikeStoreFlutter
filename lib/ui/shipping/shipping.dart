import 'package:flutter/material.dart';
import 'package:nike_store/ui/cart/price_info.dart';
import 'package:nike_store/ui/receipt/payment_receipt.dart';

class ShippingScreen extends StatelessWidget {
  final int payblePrice;
  final int totalPrice;
  final int shippingCost;

  const ShippingScreen(
      {super.key,
      required this.payblePrice,
      required this.totalPrice,
      required this.shippingCost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('انتخاب تحویل گیرنده و شیوه پرداخت'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text(
                  'نام و نام خانوادگی',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
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
              decoration: InputDecoration(
                label: Text(
                  'آدرس',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            PriceInfo(
                payblePrice: payblePrice,
                totalPrice: totalPrice,
                shippingCost: shippingCost),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: SizedBox(
                width: MediaQuery.of(context).size.width ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton( onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentReceiptScreen(),));
                      }, child: Text('پرداخت در محل')),
                    ),
                    SizedBox(width: 8,),
                    Expanded(child: ElevatedButton(onPressed: () {}, child: Text('پرداخت اینترنتی'))),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/ui/receipt/payment_receipt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatelessWidget {
  String banckGatewayeUrl;

  PaymentGatewayScreen({super.key, required this.banckGatewayeUrl});
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            final uri =Uri.parse(url);
          
            if(uri.pathSegments.contains("checkout") && uri.host == "expertdevelopers.ir"){
               final orderId =int.parse(uri.queryParameters['order_id']!);
               Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaymentReceiptScreen(orderId: orderId),));
            }
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(banckGatewayeUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}

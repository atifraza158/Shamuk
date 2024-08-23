import 'package:flutter/material.dart';
import 'package:multivendor/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderInvoiceScreen extends StatefulWidget {
  const OrderInvoiceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {
 
 late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            const CircularProgressIndicator(color: Palette.themecolor,);
            const Text("Please Wait...");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://shamukh.digitalelliptical.com/invoice'));
    // #enddocregion webview_controller
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themewhitecolor,
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        title: const Text(
          "Order Invoice",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:  WebViewWidget(controller: controller),
    );
  }
}

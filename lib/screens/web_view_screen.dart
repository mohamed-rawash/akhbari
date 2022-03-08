import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebviewScreen extends StatelessWidget {

  final String url;
  WebviewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: WebView(
          initialUrl: url,
        ),
      ),
    );
  }
}

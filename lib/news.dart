import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  String? link;
  NewsDetail({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: link,
      ),
    );
  }
}

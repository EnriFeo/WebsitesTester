import 'package:flutter/material.dart';

/*class UrlOk {
  String url;
  int statusCode;

  UrlOk(this.url, this.statusCode);

  @override
  String toString() {
    return "{url: $url, statusCode: $statusCode}";
  }
}*/

class UrlOk extends StatelessWidget {
  final String url;
  final int statusCode;

  const UrlOk({super.key, required this.url, required this.statusCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.5)),
      child: Column(
        children: [Text(url), Text(statusCode.toString())],
      ),
    );
  }
}

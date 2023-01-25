import 'package:flutter/material.dart';

import 'web_screen.dart';

class TestWeb extends StatefulWidget {
  const TestWeb({Key? key}) : super(key: key);

  @override
  State<TestWeb> createState() => _TestWebState();
}

class _TestWebState extends State<TestWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewWidget(url: 'https://stackoverflow.com/questions/48403786/how-to-open-particular-screen-on-clicking-on-push-notification-for-flutter',),
    );
  }
}

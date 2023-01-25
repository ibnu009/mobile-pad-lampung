import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pad_lampung/core/theme/app_primary_theme.dart';
import 'package:pad_lampung/presentation/components/generic/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../button/primary_button.dart';

class WebviewWidget extends StatefulWidget {
  final String url;
  final Function()? onCancelTap;

  const WebviewWidget({Key? key, required this.url, this.onCancelTap}) : super(key: key);

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Builder(builder: (BuildContext context) {
        return Stack(
          children: [
            WebView(
              key: _key,
              gestureRecognizers: gestureRecognizers,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });
              },
              gestureNavigationEnabled: true,
            ),
            isLoading
                ? const Center(
                    child: LoadingWidget(),
                  )
                : const SizedBox(),

            Visibility(
              visible: widget.onCancelTap != null,
              child: Positioned(
                bottom: 16,
                left: 32,
                right: 32,
                child: PrimaryButton(
                    context: context,
                    isEnabled: true,
                    color: Colors.red,
                    onPressed: widget.onCancelTap ?? (){},
                    horizontalPadding: 32,
                    height: 45,
                    text: 'Batal'),
              ),
            ),
          ],
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
        });
  }
}

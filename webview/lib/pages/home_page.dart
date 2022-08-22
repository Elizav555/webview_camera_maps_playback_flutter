import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Completer<WebViewController>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                autofocus: true,
                color: Colors.cyan,
                onPressed: () async {
                  if (snapshot.connectionState == ConnectionState.done &&
                      await controller?.canGoBack() == true) {
                    await controller?.goBack();
                  }
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
              ),
              IconButton(
                color: Colors.cyan,
                onPressed: () async {
                  if (await controller?.canGoForward() == true) {
                    await controller?.goForward();
                  }
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
              ),
              IconButton(
                color: Colors.purple,
                onPressed: () async {
                  if (_isLoading) {
                    await controller?.loadUrl('');
                  } else {
                    await controller?.reload();
                  }
                },
                icon: Icon(_isLoading ? Icons.stop : Icons.refresh_outlined),
              ),
              Expanded(
                child: TextField(
                  onSubmitted: (value) {
                    controller?.loadUrl(value);
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: 'Go',
                  ),
                ),
              ),
            ],
          ),
          body: Stack(children: [
            WebView(
              initialUrl: 'https://flutter.dev/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageStarted: (_) => setState(() {
                _isLoading = true;
              }),
              gestureNavigationEnabled: true,
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                  ))
                : Container()
          ]),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

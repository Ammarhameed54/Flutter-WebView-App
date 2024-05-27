import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewapp/my_web_view.dart';

class Webview extends StatefulWidget {
  const Webview({super.key});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(Uri.parse("https://www.google.com/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView App"),
        actions: [
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    if (await controller.canGoBack()) {
                      await controller.goBack();
                    } else {
                      messenger.showSnackBar(
                        const SnackBar(content: Text("No Back History Found")),
                      );
                      return;
                    }
                  }),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(content: Text("No Forward History Found")),
                    );
                    return;
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () {
                  controller.reload();
                },
              )
            ],
          )
        ],
      ),
      body: MyWebView(
        controller: controller,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../src_export.dart';

class StripeConnectWebviewPage extends StatefulWidget {
  final String onboardingUrl;

  const StripeConnectWebviewPage({
    super.key,
    required this.onboardingUrl,
  });

  @override
  State<StripeConnectWebviewPage> createState() =>
      _StripeConnectWebviewPageState();
}

class _StripeConnectWebviewPageState extends State<StripeConnectWebviewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
            debugPrint('Stripe Connect Webview started: $url');
            _checkUrlCompletion(url);
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            debugPrint('Stripe Connect Webview finished: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_checkUrlCompletion(request.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.onboardingUrl));
  }

  bool _checkUrlCompletion(String url) {
    if (url.contains('stripe-connect/return') ||
        url.contains('return') ||
        url.contains('success')) {
      if (mounted) {
        Navigator.pop(context, true);
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Account Onboarding'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

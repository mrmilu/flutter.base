import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../router/app_router.dart';
import '../router/page_names.dart';

Future<void> openWebView({
  required BuildContext context,
  required String title,
  required String url,
}) async {
  final isPdf = url.toLowerCase().endsWith('.pdf');
  if (isPdf && Platform.isAndroid) {
    await _openPdfExternally(context: context, title: title, url: url);
    return;
  }
  routerApp.pushNamed(
    PageNames.webView,
    extra: {
      "title": title,
      "url": url,
    },
  );
}

Future<void> _openPdfExternally({
  required BuildContext context,
  required String title,
  required String url,
}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

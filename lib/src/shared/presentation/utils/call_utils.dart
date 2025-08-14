import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../extensions/buildcontext_extensions.dart';

Future<void> callSupport(BuildContext context) async {
  final phone = context.cl.translate('phones.support');
  final url = 'tel:+34$phone';
  launchUrl(Uri.parse(url));
}

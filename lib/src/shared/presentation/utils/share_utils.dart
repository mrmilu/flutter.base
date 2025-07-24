import 'dart:ui';

import 'package:share_plus/share_plus.dart';

Future<void> shareFile({
  String? message,
  required String documentPath,
}) async {
  SharePlus.instance.share(
    ShareParams(
      text: message,
      sharePositionOrigin: const Rect.fromLTWH(5, 25, 5, 5),
      files: [XFile(documentPath)],
    ),
  );
}

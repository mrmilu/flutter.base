import 'dart:typed_data';
import 'dart:ui';

import 'package:cross_file/cross_file.dart';

abstract class IEditImageService {
  Future<XFile?> crop(Rect rect, Uint8List rawImage, {int quality});

  Future<void> clearEditFolder();
}

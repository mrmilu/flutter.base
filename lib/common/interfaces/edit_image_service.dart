import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

abstract class IEditImageService {
  Future<File?> crop(Rect rect, Uint8List rawImage, {int quality});

  Future<void> clearEditFolder();
}

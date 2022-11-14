import 'dart:io';

abstract class IImageCompressService {
  Future<File?> byQuality(File file, {int quality});
}

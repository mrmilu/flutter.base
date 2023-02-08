import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_mrmilu/src/interfaces/image_compress_service.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressService implements IImageCompressService {
  @override
  Future<File?> byQuality(File file, {int quality = 70}) async {
    final inputPath = file.absolute.path;
    final lastIndex = inputPath.lastIndexOf(RegExp(r'.jp'));
    final dir = await getApplicationDocumentsDirectory();
    final dateTime = DateTime.now().toIso8601String();
    final extension = lastIndex >= 0 ? inputPath.substring(lastIndex) : '.jpg';
    final outPath = "${dir.absolute.path}/${dateTime}_out$extension";
    try {
      final File? result = await FlutterImageCompress.compressAndGetFile(
        inputPath,
        outPath,
        quality: quality,
      );
      if (result != null) {
        return result;
      }
    } catch (e) {
      throw 'Error to compress image: $e';
    }
    return null;
  }
}

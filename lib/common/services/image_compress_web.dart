import 'package:browser_image_compression/browser_image_compression.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/common/interfaces/image_compress_service.dart';

class ImageCompressService implements IImageCompressService {
  @override
  Future<XFile> byQuality(XFile file, {int quality = 70}) async {
    try {
      final result = await BrowserImageCompression.compressImageByXFile(
        file,
        Options(initialQuality: 70 / 100),
      );
      return XFile.fromData(result);
    } catch (e) {
      throw 'Error to compress image: $e';
    }
  }
}

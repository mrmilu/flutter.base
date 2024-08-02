import 'package:flutter_base/src/shared/domain/interfaces/i_image_compress_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressService implements IImageCompressService {
  @override
  Future<XFile?> byQuality(XFile file, {int quality = 70}) async {
    final inputPath = file.path;
    final lastIndex = inputPath.lastIndexOf(RegExp(r'.jp'));
    final dir = await getApplicationDocumentsDirectory();
    final dateTime = DateTime.now().toIso8601String();
    final extension = lastIndex >= 0 ? inputPath.substring(lastIndex) : '.jpg';
    final outPath = '${dir.absolute.path}/${dateTime}_out$extension';
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        inputPath,
        outPath,
        quality: quality,
      );
      if (result != null) {
        return XFile(result.path);
      }
    } catch (e) {
      throw 'Error to compress image: $e';
    }
    return null;
  }
}

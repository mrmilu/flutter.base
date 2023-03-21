import 'package:cross_file/cross_file.dart';

abstract class IImageCompressService {
  Future<XFile?> byQuality(XFile file, {int quality});
}

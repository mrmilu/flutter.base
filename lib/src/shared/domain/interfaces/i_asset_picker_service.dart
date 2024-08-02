import 'package:cross_file/cross_file.dart';

abstract class IAssetPickerService {
  Future<XFile?> imageFromGallery();

  Future<XFile?> imageFromCamera();
}

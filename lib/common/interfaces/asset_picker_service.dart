import 'dart:io';

abstract class IAssetPickerService {
  Future<File?> imageFromGallery();

  Future<File?> imageFromCamera();
}

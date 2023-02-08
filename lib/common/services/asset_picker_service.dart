import 'dart:io';

import 'package:flutter_mrmilu/src/interfaces/asset_picker_service.dart';
import 'package:image_picker/image_picker.dart';

class AssetPickerService implements IAssetPickerService {
  final ImagePicker _picker;

  AssetPickerService() : _picker = ImagePicker();

  @override
  Future<File?> imageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    return image?.path != null ? File(image!.path) : null;
  }

  @override
  Future<File?> imageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image?.path != null ? File(image!.path) : null;
  }
}

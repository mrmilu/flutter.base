import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:image_picker/image_picker.dart';

class AssetPickerService implements IAssetPickerService {
  final ImagePicker _picker;

  AssetPickerService() : _picker = ImagePicker();

  @override
  Future<XFile?> imageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    return image?.path != null ? XFile(image!.path) : null;
  }

  @override
  Future<XFile?> imageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image?.path != null ? XFile(image!.path) : null;
  }
}

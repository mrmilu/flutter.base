import 'dart:io';

import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:flutter_base/common/interfaces/fs_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ImageFromCameraUseCase {
  final IAssetPickerService _assetPickerService;
  final IFsRepository _fsRepository;

  ImageFromCameraUseCase(this._fsRepository, this._assetPickerService);

  Future<File?> call() async {
    final image = await _assetPickerService.imageFromCamera();
    if (image == null) return null;
    return _fsRepository.createFile(
      CreateFileInput(path: "share", bytes: image.readAsBytesSync()),
    );
  }
}

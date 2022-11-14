import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:flutter_base/common/interfaces/fs_repository.dart';


@Injectable()
class ImageFromGalleryUseCase {
  final IAssetPickerService _assetPickerService;
  final IFsRepository _fsRepository;

  ImageFromGalleryUseCase(this._fsRepository, this._assetPickerService);

  Future<File?> call() async {
    final image = await _assetPickerService.imageFromGallery();
    if(image == null) return null;
    return await _fsRepository.createFile(CreateFileInput(path: "share", bytes: image.readAsBytesSync()));
  }
}
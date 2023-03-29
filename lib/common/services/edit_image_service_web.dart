import 'dart:typed_data';
import 'dart:ui';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/common/interfaces/fs_repository.dart';
import 'package:image/image.dart';

const _editImagePath = 'edited_images';

class EditImageService implements IEditImageService {
  final IFsRepository _fsRepository;

  EditImageService(this._fsRepository);

  @override
  Future<XFile?> crop(Rect rect, Uint8List rawImage) async {
    Image? image = decodeImage(rawImage);

    if (image == null) return null;

    image = bakeOrientation(image);

    image = copyCrop(
      image,
      rect.left.toInt(),
      rect.top.toInt(),
      rect.width.toInt(),
      rect.height.toInt(),
    );

    final modifiedRawImage = encodeJpg(image);

    return _fsRepository.createFile(
      CreateFileInput(
        path: _editImagePath,
        bytes: Uint8List.fromList(modifiedRawImage),
      ),
    );
  }

  @override
  Future<void> clearEditFolder() async {
    await _fsRepository.deleteDirectory(_editImagePath);
  }
}

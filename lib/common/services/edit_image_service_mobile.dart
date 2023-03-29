import 'dart:typed_data';
import 'dart:ui';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/common/interfaces/fs_repository.dart';
import 'package:image_editor/image_editor.dart';

const _editImagePath = 'edited_images';

class EditImageService implements IEditImageService {
  final IFsRepository _fsRepository;

  EditImageService(this._fsRepository);

  @override
  Future<XFile?> crop(Rect rect, Uint8List rawImage) async {
    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect));

    final Uint8List? result = await ImageEditor.editImage(
      image: rawImage,
      imageEditorOption: option,
    );

    if (result == null) return null;

    return _fsRepository
        .createFile(CreateFileInput(path: _editImagePath, bytes: result));
  }

  @override
  Future<void> clearEditFolder() async {
    await _fsRepository.deleteDirectory(_editImagePath);
  }
}

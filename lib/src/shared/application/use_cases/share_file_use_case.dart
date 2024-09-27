import 'package:flutter/services.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_fs_repository.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_share_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

class ShareFileUseCaseInput {
  final Uint8List bytes;
  final String filename;
  final String? text;
  final String? subject;

  const ShareFileUseCaseInput({
    required this.bytes,
    required this.filename,
    this.text,
    this.subject,
  });
}

@Injectable()
class ShareFileUseCase {
  final IShareService _shareService;
  final IFsRepository _fsRepository;

  ShareFileUseCase(this._fsRepository, this._shareService);

  Future<void> call(ShareFileUseCaseInput input) async {
    final file = await _fsRepository.createFile(
      CreateFileInput(
        path: 'share',
        bytes: input.bytes,
        name: input.filename,
      ),
    );
    final shareInput = ShareFileInput(
      files: [XFile(file.path)],
      subject: input.subject,
      text: input.text,
    );
    await _shareService.file(shareInput);
  }
}

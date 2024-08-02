import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_fs_repository.dart';

class FsRepository implements IFsRepository {
  @override
  Future<XFile> createFile(CreateFileInput input) async {
    String? name = input.name;
    name ??= '${DateTime.now().millisecondsSinceEpoch}';
    return XFile.fromData(input.bytes, name: name);
  }

  @override
  Future<void> deleteDirectory(String path) async {}
}

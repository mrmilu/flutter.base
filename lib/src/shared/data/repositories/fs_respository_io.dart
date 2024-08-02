import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_fs_repository.dart';
import 'package:path_provider/path_provider.dart';

class FsRepository implements IFsRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<XFile> createFile(CreateFileInput input) async {
    final localPath = await _localPath;
    String? name = input.name;
    name ??= '${DateTime.now().millisecondsSinceEpoch}';
    final file = File('$localPath/${input.path}/$name')
      ..createSync(recursive: true);
    final result = file..writeAsBytesSync(input.bytes);

    return XFile(result.path);
  }

  @override
  Future<void> deleteDirectory(String path) async {
    final localPath = await _localPath;
    final dir = Directory('$localPath/$path');
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
  }
}

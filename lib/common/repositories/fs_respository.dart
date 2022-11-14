import 'dart:io';
import 'package:flutter_base/common/interfaces/fs_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@Injectable(as: IFsRepository)
class FsRepository implements IFsRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<File> createFile(
      CreateFileInput input) async {
    final localPath = await _localPath;
    String? name = input.name;
    name ??= '${DateTime.now().millisecondsSinceEpoch}';
    final file = File('$localPath/${input.path}/$name')..createSync(recursive: true);
    return file..writeAsBytesSync(input.bytes);
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

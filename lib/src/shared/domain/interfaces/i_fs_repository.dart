import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';

abstract class IFsRepository {
  Future<XFile> createFile(CreateFileInput input);

  Future<void> deleteDirectory(String path);
}

class CreateFileInput {
  final String path;
  final Uint8List bytes;
  final String? name;

  CreateFileInput({
    required this.path,
    required this.bytes,
    this.name,
  });
}

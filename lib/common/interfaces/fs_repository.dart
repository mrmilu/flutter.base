import 'dart:io';
import 'dart:typed_data';

abstract class IFsRepository {
  Future<File> createFile(CreateFileInput input);

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

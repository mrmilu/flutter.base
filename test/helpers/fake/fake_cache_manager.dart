// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:typed_data';

import 'package:file/memory.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_image_data.dart';

class FakeImageCacheManager extends Mock implements ImageCacheManager {
  FakeImageCacheManager() {
    const chunkSize = 8;
    final chunks = <Uint8List>[
      for (int offset = 0;
          offset < kTransparentImage.length;
          offset += chunkSize)
        Uint8List.fromList(
          kTransparentImage.skip(offset).take(chunkSize).toList(),
        ),
    ];

    when(
      () => getImageFile(
        any(),
        key: any(named: 'key'),
        headers: any(named: 'headers'),
        withProgress: any(named: 'withProgress'),
        maxHeight: any(named: 'maxHeight'),
        maxWidth: any(named: 'maxWidth'),
      ),
    ).thenAnswer(
      (_) => _createResultStream(
        'url',
        chunks,
        kTransparentImage,
      ),
    );
  }

  Stream<FileResponse> _createResultStream(
    String url,
    List<Uint8List> chunks,
    List<int> imageData,
  ) async* {
    final totalSize = imageData.length;
    var downloaded = 0;
    for (var chunk in chunks) {
      downloaded += chunk.length;
      yield DownloadProgress(url, totalSize, downloaded);
    }
    final file = MemoryFileSystem().systemTempDirectory.childFile('test.jpg');
    await file.writeAsBytes(imageData);
    yield FileInfo(
      file,
      FileSource.Online,
      DateTime.now().add(const Duration(days: 1)),
      url,
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/failures/endpoints/download_file_failure.dart';
import '../../domain/interfaces/i_download_file_repository.dart';
import '../../presentation/helpers/handle_request.dart';
import '../../presentation/helpers/resource.dart';

class DownloadFileRepositoryImpl implements IDownloadFileRepository {
  final Dio httpClient;
  DownloadFileRepositoryImpl(this.httpClient);

  @override
  Future<Resource<DownloadFileFailure, String>> generateFile(
    String documentId,
  ) async {
    return handleRequest(
      request: () async {
        final result = await httpClient.get(
          '/api/documents/$documentId',
        );
        final resultUrl = result.data['document'] as String;
        return resultUrl;
      },
      fromString: DownloadFileFailure.fromString,
      general: DownloadFileFailure.general,
      mockData: '',
      useMockData: false,
    );
  }

  @override
  Future<Resource<DownloadFileFailure, String>> downloadAndSaveFile(
    String urlFile, {
    bool isTempFile = false,
  }) async {
    return handleRequest(
      request: () async {
        final now = DateTime.now();
        final formattedDate = '${now.year}-${now.month}-${now.day}';
        final formattedTime = '${now.hour}-${now.minute}';
        final formattedFileName = 'file-$formattedDate-$formattedTime.pdf';

        final dir = isTempFile
            ? await getTemporaryDirectory()
            : Platform.isAndroid
            ? await getDownloadsDirectory() ?? await getTemporaryDirectory()
            : await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/$formattedFileName';

        await Dio().download(
          urlFile,
          filePath,
        );
        return filePath;
      },
      fromString: DownloadFileFailure.fromString,
      general: DownloadFileFailure.general,
      mockData: '',
      useMockData: false,
    );
  }

  @override
  Future<Resource<DownloadFileFailure, String>> saveFileFromPath(
    String path,
  ) async {
    return handleRequest(
      request: () async {
        final bytes = await File(path).readAsBytes();
        final fileName = path.split('/').last;
        final dir = Platform.isAndroid
            ? await getDownloadsDirectory() ?? await getTemporaryDirectory()
            : await getApplicationDocumentsDirectory();

        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        return file.path;
      },
      fromString: DownloadFileFailure.fromString,
      general: DownloadFileFailure.general,
      mockData: '',
      useMockData: false,
    );
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/failures/endpoints/download_file_failure.dart';
import '../../domain/failures/endpoints/general_base_failure.dart';
import '../../domain/interfaces/i_download_file_repository.dart';
import '../../helpers/resource.dart';
import '../../presentation/utils/extensions/dio_exception_extension.dart';

class DownloadFileRepositoryImpl extends IDownloadFileRepository {
  final Dio httpClient;
  DownloadFileRepositoryImpl(this.httpClient);

  @override
  Future<Resource<DownloadFileFailure, String>> generateFile(
    String documentId,
  ) async {
    try {
      final result = await httpClient.get(
        '/api/documents/$documentId',
      );
      final resultUrl = result.data['document'] as String;
      return Resource.success(resultUrl);
    } on DioException catch (e) {
      return Resource.failure(
        e.toFailure(
          DownloadFileFailure.fromString,
          const DownloadFileFailure.problemWithSaveFile(),
        ),
      );
    } catch (e) {
      return Resource.failure(const DownloadFileFailure.problemWithSaveFile());
    }
  }

  @override
  Future<Resource<DownloadFileFailure, String>> downloadAndSaveFile(
    String urlFile, {
    bool isTempFile = false,
  }) async {
    try {
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

      return Resource.success(filePath);
    } on DioException catch (e) {
      return Resource.failure(
        e.toFailure(
          DownloadFileFailure.fromString,
          const DownloadFileFailure.general(
            GeneralBaseFailure.unexpectedError(),
          ),
        ),
      );
    } catch (e) {
      return Resource.failure(const DownloadFileFailure.problemWithSaveFile());
    }
  }

  @override
  Future<Resource<DownloadFileFailure, String>> saveFileFromPath(
    String path,
  ) async {
    try {
      final bytes = await File(path).readAsBytes();
      final fileName = path.split('/').last;
      final dir = Platform.isAndroid
          ? await getDownloadsDirectory() ?? await getTemporaryDirectory()
          : await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(bytes);
      return Resource.success(file.path);
    } catch (e) {
      return Resource.failure(const DownloadFileFailure.problemWithSaveFile());
    }
  }
}

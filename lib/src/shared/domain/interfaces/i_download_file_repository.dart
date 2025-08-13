import '../../helpers/resource.dart';
import '../failures/endpoints/download_file_failure.dart';

abstract class IDownloadFileRepository {
  Future<Resource<DownloadFileFailure, String>> generateFile(String documentId);

  Future<Resource<DownloadFileFailure, String>> downloadAndSaveFile(
    String urlFile, {
    bool isTempFile = false,
  });

  Future<Resource<DownloadFileFailure, String>> saveFileFromPath(String path);
}

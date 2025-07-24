import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/failures/download_file_failure.dart';
import '../../../domain/interfaces/i_download_file_repository.dart';
import '../../../helpers/resource.dart';
import '../base_cubit.dart';

part 'download_file_cubit.freezed.dart';
part 'download_file_state.dart';

class DownloadFileCubit extends BaseCubit<DownloadFileState> {
  DownloadFileCubit({required this.downloadFileRepository})
    : super(DownloadFileState.initial());
  final IDownloadFileRepository downloadFileRepository;

  Future<void> generateFile(String documentId) async {
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: Resource.loading()));
    final result = await downloadFileRepository.generateFile(documentId);
    emitIfNotDisposed(state.copyWith(resourceGenerateFile: result));
    result.whenIsSuccess((url) {
      downloadTemp(url);
    });
  }

  Future<void> downloadTemp(String url) async {
    emitIfNotDisposed(
      state.copyWith(resourceDownloadFileTemp: Resource.loading()),
    );
    final result = await downloadFileRepository.downloadAndSaveFile(
      url,
      isTempFile: true,
    );
    emitIfNotDisposed(state.copyWith(resourceDownloadFileTemp: result));
  }

  Future<void> downloadFileFromUrl() async {
    final documentUrl = state.resourceGenerateFile.whenIsSuccess((url) => url);
    if (documentUrl == null) return;
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: Resource.loading()));
    final result = await downloadFileRepository.downloadAndSaveFile(
      documentUrl,
    );
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: result));
  }

  Future<void> downloadFileFromUrlExternal(String documentUrl) async {
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: Resource.loading()));
    final result = await downloadFileRepository.downloadAndSaveFile(
      documentUrl,
    );
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: result));
  }

  Future<void> downloadFileFromTemp() async {
    final localPath = state.resourceDownloadFileTemp.whenIsSuccess(
      (path) => path,
    );
    if (localPath == null) return;
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: Resource.loading()));
    final result = await downloadFileRepository.saveFileFromPath(localPath);
    emitIfNotDisposed(state.copyWith(resourceDownloadFile: result));
  }

  // Future<void> openFile() async {
  //   String? filePath;
  //   state.resourceDownloadFile.whenIsSuccess((path) => filePath = path);
  //   await OpenFile.open(filePath);
  // }

  // Future<void> openFileTemp() async {
  //   String? filePath;
  //   state.resourceDownloadFileTemp.whenIsSuccess((path) => filePath = path);
  //   await OpenFile.open(filePath);
  // }
}

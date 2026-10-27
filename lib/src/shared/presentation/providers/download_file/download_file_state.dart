part of 'download_file_cubit.dart';

@freezed
abstract class DownloadFileState with _$DownloadFileState {
  factory DownloadFileState({
    required Resource<DownloadFileFailure, String> resourceGenerateFile,
    required Resource<DownloadFileFailure, String> resourceDownloadFileTemp,
    required Resource<DownloadFileFailure, String> resourceDownloadFile,
  }) = _DownloadFileState;

  factory DownloadFileState.initial() => _DownloadFileState(
    resourceGenerateFile: const Resource.none(),
    resourceDownloadFile: const Resource.none(),
    resourceDownloadFileTemp: const Resource.none(),
  );
}

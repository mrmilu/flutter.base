import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/interfaces/i_download_file_repository.dart';
import '../../helpers/toasts.dart';
import '../providers/download_file/download_file_cubit.dart';
import '../utils/share_utils.dart';

typedef DownloadDocumentBuilder =
    Widget Function(
      BuildContext context,
      VoidCallback onDownload,
      bool isLoading,
    );

class WrapperDownloadDocumentWidget extends StatelessWidget {
  const WrapperDownloadDocumentWidget({
    super.key,
    required this.documentId,
    required this.builder,
    this.documentUrl,
  });
  final String documentId;
  final String? documentUrl;
  final DownloadDocumentBuilder builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadFileCubit>(
      create: (context) => DownloadFileCubit(
        downloadFileRepository: context.read<IDownloadFileRepository>(),
      ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<DownloadFileCubit, DownloadFileState>(
            listenWhen: (previous, current) =>
                previous.resourceGenerateFile != current.resourceGenerateFile,
            listener: (context, state) {
              state.resourceGenerateFile.whenIsFailure(
                (e) {
                  showError(context, message: e.toTranslate(context));
                },
              );
              state.resourceGenerateFile.whenIsSuccess((_) {
                context.read<DownloadFileCubit>().downloadFileFromUrl();
              });
            },
          ),
          BlocListener<DownloadFileCubit, DownloadFileState>(
            listenWhen: (previous, current) =>
                previous.resourceDownloadFile != current.resourceDownloadFile,
            listener: (context, state) {
              state.resourceDownloadFile.whenIsFailure(
                (e) {
                  showError(context, message: e.toTranslate(context));
                },
              );
              state.resourceDownloadFile.whenIsSuccess((path) {
                if (Platform.isAndroid) {
                  // context.read<DownloadFileCubit>().openFile();
                } else {
                  shareFile(documentPath: path);
                }
              });
            },
          ),
        ],
        child: BlocBuilder<DownloadFileCubit, DownloadFileState>(
          builder: (context, stateDownload) {
            final isLoading =
                stateDownload.resourceGenerateFile.isLoading ||
                stateDownload.resourceDownloadFile.isLoading;
            return builder(
              context,
              () => documentUrl != null
                  ? context
                        .read<DownloadFileCubit>()
                        .downloadFileFromUrlExternal(documentUrl!)
                  : context.read<DownloadFileCubit>().generateFile(documentId),
              isLoading,
            );
          },
        ),
      ),
    );
  }
}

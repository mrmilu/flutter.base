import 'package:share_plus/share_plus.dart';

abstract class IShareService {
  Future<ShareStatus> file(ShareFileInput input);
}

class ShareFileInput {
  final List<XFile> files;
  final String? text;
  final String? subject;

  const ShareFileInput({
    required this.files,
    this.text,
    this.subject,
  });
}

enum ShareStatus {
  success,
  dismissed,
  unavailable,
}

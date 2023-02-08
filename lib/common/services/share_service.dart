import 'package:flutter_base/common/interfaces/share_service.dart';
import 'package:share_plus/share_plus.dart';

class ShareService implements IShareService {
  @override
  Future<ShareStatus> file(ShareFileInput input) async {
    final result = await Share.shareXFiles(
      input.files,
      subject: input.subject,
      text: input.text,
    );
    if (result.raw.isEmpty && result.status == ShareResultStatus.dismissed) {
      return ShareStatus.dismissed;
    } else if (result.raw.isNotEmpty) {
      return ShareStatus.success;
    } else {
      return ShareStatus.unavailable;
    }
  }
}

import 'package:flutter/cupertino.dart';

import '../../../domain/types/document_type.dart';
import '../buildcontext_extensions.dart';

extension DocumentTypeExtension on DocumentType {
  String toTranslate(BuildContext context) {
    switch (this) {
      case DocumentType.nie:
        return context.cl.translate('enums.documentType.nie');
      case DocumentType.nif:
        return context.cl.translate('enums.documentType.nif');
    }
  }
}

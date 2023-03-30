import 'package:cross_file/cross_file.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/images/editable_image_preview.dart'
    show getEditorConfig;

class EditableImagePreview extends StatelessWidget {
  final XFile image;
  final GlobalKey<ExtendedImageEditorState> editorKey;
  final bool enableCircleMask;

  const EditableImagePreview({
    super.key,
    required this.image,
    required this.editorKey,
    this.enableCircleMask = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      image.path,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      cacheRawData: true,
      initEditorConfigHandler: (_) => getEditorConfig(
        enableCircleMask: enableCircleMask,
      ),
    );
  }
}

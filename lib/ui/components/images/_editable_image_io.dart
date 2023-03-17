import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/components/images/circle_editor_crop_layer_painter.dart';

class EditableImagePreview extends StatelessWidget {
  // ignore: no-object-declaration
  final Object image;
  final GlobalKey<ExtendedImageEditorState> editorKey;
  final bool circleMask;

  const EditableImagePreview({
    super.key,
    required this.image,
    required this.editorKey,
    this.circleMask = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.file(
      image as File,
      extendedImageEditorKey: editorKey,
      mode: ExtendedImageMode.editor,
      fit: BoxFit.contain,
      cacheRawData: true,
      initEditorConfigHandler: (_) => EditorConfig(
        maxScale: 8.0,
        hitTestSize: 0.00000001,
        // Hack to disable corner sizing
        cropAspectRatio: 1,
        cropLayerPainter: circleMask
            ? const CircleEditorCropLayerPainter()
            : const EditorCropLayerPainter(),
        cropRectPadding: EdgeInsets.zero,
        initCropRectType: InitCropRectType.layoutRect,
        cornerSize: Size.zero,
      ),
    );
  }
}

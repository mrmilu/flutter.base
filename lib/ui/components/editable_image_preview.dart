import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';

class EditableImagePreview extends StatelessWidget {
  final File image;
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
      image,
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
        cropRectPadding: const EdgeInsets.all(0),
        initCropRectType: InitCropRectType.layoutRect,
        cornerSize: Size.zero,
      ),
    );
  }
}

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
    Canvas canvas,
    Size size,
    ExtendedImageCropLayerPainter painter,
  ) {
    // do nothing
  }

  @override
  void paintMask(
    Canvas canvas,
    Size size,
    ExtendedImageCropLayerPainter painter,
  ) {
    final Rect rect = Offset.zero & size;
    final Rect cropRect = painter.cropRect;
    final Color maskColor = painter.maskColor;
    canvas.saveLayer(rect, Paint());
    canvas.drawRect(
      rect,
      Paint()
        ..style = PaintingStyle.fill
        ..color = maskColor,
    );
    canvas.drawCircle(
      cropRect.center,
      cropRect.width / 2.0,
      Paint()..blendMode = BlendMode.clear,
    );
    canvas.restore();
  }

  @override
  void paintLines(
    Canvas canvas,
    Size size,
    ExtendedImageCropLayerPainter painter,
  ) {
    final Rect cropRect = painter.cropRect;
    if (painter.pointerDown) {
      canvas.save();
      canvas.clipPath(Path()..addOval(cropRect));
      super.paintLines(canvas, size, painter);
      canvas.restore();
    }
  }
}

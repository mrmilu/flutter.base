import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CircleEditorCropLayerPainter extends EditorCropLayerPainter {
  const CircleEditorCropLayerPainter();

  @override
  void paintCorners(
    Canvas canvas,
    Size size,
    ExtendedImageCropLayerPainter painter,
  );

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

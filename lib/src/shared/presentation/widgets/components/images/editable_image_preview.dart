import 'package:extended_image/extended_image.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/images/circle_editor_crop_layer_painter.dart';

// Compatibility with web and other platforms
// Ref: https://github.com/fluttercandies/extended_image/issues/531#issuecomment-1408071991
export 'editable_image_mobile.dart'
    if (dart.library.html) 'editable_image_web.dart';

EditorConfig getEditorConfig({bool enableCircleMask = false}) {
  return EditorConfig(
    maxScale: 8.0,
    hitTestSize: 0.00000001,
    // Hack to disable corner sizing
    cropAspectRatio: 1,
    cropLayerPainter: enableCircleMask
        ? const CircleEditorCropLayerPainter()
        : const EditorCropLayerPainter(),
    cropRectPadding: Insets.zero,
    initCropRectType: InitCropRectType.layoutRect,
    cornerSize: Size.zero,
  );
}

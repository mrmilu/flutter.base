// Compatibility with web and other platforms
// Ref: https://github.com/fluttercandies/extended_image/issues/531#issuecomment-1408071991
export '_editable_image_io.dart'
    if (dart.library.html) '_editable_image_web.dart';

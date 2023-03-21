// Compatibility with web and other platforms
export '_image_compress_io.dart'
    if (dart.library.html) '_image_compress_web.dart';

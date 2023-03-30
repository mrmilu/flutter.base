// Compatibility with web and other platforms
export 'image_compress_mobile.dart'
    if (dart.library.html) 'image_compress_web.dart';

// Compatibility with web and other platforms
export '_edit_image_service_io.dart'
    if (dart.library.html) '_edit_image_service_web.dart';

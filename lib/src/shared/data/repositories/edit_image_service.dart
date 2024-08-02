// Compatibility with web and other platforms
export 'edit_image_service_mobile.dart'
    if (dart.library.html) 'edit_image_service_web.dart';

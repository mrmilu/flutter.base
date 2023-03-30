// Compatibility with web and other platforms
export 'fs_respository_io.dart'
    if (dart.library.html) 'fs_respository_web.dart';

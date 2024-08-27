import 'package:path/path.dart' as p;

extension StringExtension on String {
  static String svgExtension = '.svg';

  bool isSvg() => p.extension(this) == svgExtension;
  bool hasExtension(String fileExtension) => p.extension(this) == fileExtension;
  String toFileExtension() => p.extension(this);
  String withoutFileExtension() => p.withoutExtension(this);
  String fileNameWithoutExtension() => p.basenameWithoutExtension(this);
  String fileName() => p.basename(this);
  String setFileExtension(String fileExtension) =>
      p.setExtension(this, fileExtension);
  String truncate({int maxLength = 15}) =>
      (length <= maxLength) ? this : '${substring(0, maxLength)}...';
  String toCapitalize() => this[0].toUpperCase() + substring(1);
}

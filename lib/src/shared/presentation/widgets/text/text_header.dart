import 'package:flutter/widgets.dart';

import '../../utils/styles/text_styles.dart';

class TextHeader extends StatelessWidget {
  final String label;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const TextHeader._(
    this.label, {
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: style,
    );
  }

  factory TextHeader.one(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextHeader._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.headline1.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextHeader.two(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextHeader._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.headline2.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextHeader.three(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextHeader._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.headline3.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextHeader.four(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextHeader._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.headline4.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

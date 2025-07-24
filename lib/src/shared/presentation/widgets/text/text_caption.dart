import 'package:flutter/widgets.dart';

import '../../utils/extensions/text_style.dart';
import '../../utils/styles/text_styles.dart';

class TextCaption extends StatelessWidget {
  final String label;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  const TextCaption._(
    this.label, {
    required this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = style.copyWith(
      decoration: textDecoration != TextDecoration.underline
          ? textDecoration
          : null,
    );
    if (textDecoration == TextDecoration.underline) {
      textStyle = textStyle.underlined();
    }

    return Text(
      label,
      style: textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  factory TextCaption.one(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? textDecoration,
    double? letterSpacing,
    double? height,
  }) {
    return TextCaption._(
      label,
      style: TextStyles.caption1.copyWith(
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textDecoration: textDecoration,
    );
  }

  factory TextCaption.two(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? textDecoration,
    double? height,
  }) {
    return TextCaption._(
      label,
      style: TextStyles.caption2.copyWith(
        color: color,
        height: height,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textDecoration: textDecoration,
    );
  }

  factory TextCaption.three(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? textDecoration,
    double? height,
  }) {
    return TextCaption._(
      label,
      style: TextStyles.caption3.copyWith(
        color: color,
        height: height,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textDecoration: textDecoration,
    );
  }
}

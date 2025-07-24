import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/extensions/text_style.dart';
import '../../utils/styles/text_styles.dart';

class TextBody extends StatelessWidget {
  final String label;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final TextDecoration? textDecoration;

  const TextBody._(
    this.label, {
    required this.style,
    this.textAlign,
    this.maxLines,
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
      textStyle = textStyle.underlined(distance: 2.5);
    }
    return Text(
      label,
      style: textStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  factory TextBody.one(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontStyle? fontStyle,
    TextDecoration? textDecoration,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextBody._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      textDecoration: textDecoration,
      style: TextStyles.body1.copyWith(
        color: color,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  factory TextBody.two(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontStyle? fontStyle,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextBody._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.body2.copyWith(
        color: color,
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}

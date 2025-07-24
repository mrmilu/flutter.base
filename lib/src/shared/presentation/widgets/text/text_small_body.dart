import 'package:flutter/widgets.dart';

import '../../utils/styles/text_styles.dart';

class TextSmallBody extends StatelessWidget {
  final String label;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const TextSmallBody._(
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

  factory TextSmallBody.one(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? height,
    FontWeight? fontWeight,
  }) {
    return TextSmallBody._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.small1.copyWith(
        color: color,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextSmallBody.two(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    double? height,
    FontWeight? fontWeight,
  }) {
    return TextSmallBody._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.small2.copyWith(
        color: color,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}

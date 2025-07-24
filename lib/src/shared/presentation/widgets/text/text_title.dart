import 'package:flutter/widgets.dart';

import '../../utils/styles/text_styles.dart';

class TextTitle extends StatelessWidget {
  final String label;
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const TextTitle._(
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

  factory TextTitle.one(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title1.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextTitle.two(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title2.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  factory TextTitle.three(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title3.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  factory TextTitle.four(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title4.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  factory TextTitle.five(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title5.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  factory TextTitle.six(
    String label, {
    Color? color,
    int? maxLines,
    TextAlign? textAlign,
    TextOverflow? overflow,
    FontWeight? fontWeight,
    double? height,
  }) {
    return TextTitle._(
      label,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyles.title6.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}

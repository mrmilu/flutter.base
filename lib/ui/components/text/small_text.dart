// ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class SmallText extends StatelessWidget {
  final String label;
  final TextStyle style;
  final TextAlign? textAlign;

  const SmallText._(
    this.label, {
    required this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      style: style,
    );
  }

  factory SmallText.xs(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      SmallText._(
        label,
        style: TextStyles.smallXxs.copyWith(
          color: color,
        ),
        textAlign: textAlign,
      );

  factory SmallText.s(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      SmallText._(
        label,
        style: TextStyles.smallS.copyWith(
          color: color,
        ),
        textAlign: textAlign,
      );

  factory SmallText.m(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      SmallText._(
        label,
        style: TextStyles.smallM.copyWith(
          color: color,
        ),
        textAlign: textAlign,
      );

  factory SmallText.l(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      SmallText._(
        label,
        style: TextStyles.smallL.copyWith(
          color: color,
        ),
        textAlign: textAlign,
      );
}

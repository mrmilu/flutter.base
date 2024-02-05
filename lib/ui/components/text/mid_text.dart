// ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class MidText extends StatelessWidget {
  final String label;
  final TextStyle style;
  final TextAlign? textAlign;

  const MidText._(
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

  factory MidText.xs(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midXs.copyWith(
          color: color,
        ),
      );

  factory MidText.s(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midS.copyWith(
          color: color,
        ),
      );

  factory MidText.m(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midM.copyWith(
          color: color,
        ),
      );

  factory MidText.l(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midL.copyWith(
          color: color,
        ),
      );

  factory MidText.xl(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midXl.copyWith(
          color: color,
        ),
      );

  factory MidText.xxl(
    String label, {
    Color? color,
    TextAlign? textAlign,
  }) =>
      MidText._(
        label,
        textAlign: textAlign,
        style: TextStyles.midXxl.copyWith(
          color: color,
        ),
      );
}

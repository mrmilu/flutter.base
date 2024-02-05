// ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

class HighText extends StatelessWidget {
  final String label;
  final TextStyle style;

  const HighText._(
    this.label, {
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style,
    );
  }

  factory HighText.s(String label, {Color? color}) =>
      HighText._(label, style: TextStyles.highS.copyWith(color: color));

  factory HighText.m(String label, {Color? color}) =>
      HighText._(label, style: TextStyles.highM.copyWith(color: color));

  factory HighText.l(String label, {Color? color}) =>
      HighText._(label, style: TextStyles.highL.copyWith(color: color));

  factory HighText.xl(String label, {Color? color}) =>
      HighText._(label, style: TextStyles.highXl.copyWith(color: color));
}

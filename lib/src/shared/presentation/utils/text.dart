import 'package:flutter/material.dart';

bool hasTextOverflow(
  String text,
  TextStyle style, {
  double minWidth = 0,
  double maxWidth = double.infinity,
  int maxLines = 2,
}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(
      minWidth: minWidth,
      maxWidth: maxWidth,
    );
  return textPainter.didExceedMaxLines;
}

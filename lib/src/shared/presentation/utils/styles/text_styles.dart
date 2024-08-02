import 'package:flutter/material.dart';

class Fonts {
  static const String poppins = 'Poppins';
  static const String recoleta = 'Recoleta';
}

class TextStyles {
  // Small
  static const TextStyle smallXxs = TextStyle(
    fontFamily: Fonts.poppins,
    letterSpacing: -0.096,
    fontWeight: FontWeight.w400,
    fontSize: 9,
    height: 1.3,
  );
  static const TextStyle smallXs = TextStyle(
    fontFamily: Fonts.poppins,
    letterSpacing: -0.32,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.4,
  );
  static const TextStyle smallS = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.3,
  );
  static const TextStyle smallM = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.25,
    letterSpacing: -0.192,
  );
  static const TextStyle smallL = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.2,
  );

  // Mid
  static const TextStyle midXs = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.4,
    letterSpacing: -0.32,
  );
  static const TextStyle midS = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.3,
  );
  static const TextStyle midM = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.15,
  );
  static const TextStyle midL = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.22,
    letterSpacing: -0.32,
  );
  static const TextStyle midXl = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.4,
  );
  static const TextStyle midXxl = TextStyle(
    fontFamily: Fonts.poppins,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 0.875,
    letterSpacing: -0.24,
  );

  // High
  static const TextStyle highS = TextStyle(
    fontFamily: Fonts.recoleta,
    fontWeight: FontWeight.w500,
    fontSize: 22,
    height: 1.4,
    letterSpacing: -0.24,
  );
  static const TextStyle highM = TextStyle(
    fontFamily: Fonts.recoleta,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1,
    letterSpacing: -0.24,
  );
  static const TextStyle highL = TextStyle(
    fontFamily: Fonts.recoleta,
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.2,
    letterSpacing: -0.4,
  );
  static const TextStyle highXl = TextStyle(
    fontFamily: Fonts.recoleta,
    fontWeight: FontWeight.w500,
    fontSize: 40,
    height: 1.15,
    letterSpacing: -0.4,
  );
}

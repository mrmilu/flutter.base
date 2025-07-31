import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primary = Color(0xFF12EB93);
  static const Color secondary = Color(0xFFFFCE2B);
  static const Color tertiary = Color(0xFF00779F);

  static const Color background = Color(0xFFF8F8F8);
  static const Color onBackground = Color(0xFF172121);
  static const Color grey = Color(0xFF888498);
  static const Color disabled = Color(0xFFDADADA);
  // Basic
  static const Color specificBasicBlack = Color(0xff000000);
  static const Color specificBasicSemiBlack = Color(0xFF676767);
  static const Color specificBasicWhite = Color(0xffFFFFFF);
  static const Color specificBasicGrey = Color(0xFFDADADA);
  // Content
  static const Color specificContentHigh = Color(0xff322D2A);
  static const Color specificContentMid = Color(0xff7D7A78);
  static const Color specificContentLow = Color(0xff96969A);
  static final Color specificContentExtraLow = const Color(
    0xffFFFFFF,
  ).withAlpha((0.8 * 255).toInt());
  static const Color specificContentInverse = Color(0xffFFFFFF);
  // Semantic
  static const Color specificSemanticError = Color(0xFFD92D20);
  static const Color specificSemanticWarning = Color(0xFFC35605);
  static const Color specificSemanticSuccess = Color(0xFF288240);
  // Background
  static const Color specificBackgroundBase = Color(0xffFAF8F5);
  static final Color specificBackgroundOverlay1 = const Color(
    0xff000000,
  ).withAlpha((0.25 * 255).toInt());
  static final Color specificBackgroundOverlay2 = const Color(
    0xffFFFFFF,
  ).withAlpha((0.5 * 255).toInt());
  // Surface
  static const Color specificSurfaceInverse = Color(0xff000000);
  static const Color specificSurfaceHigh = Color(0xffF9ECE1);
  static final Color specificSurfaceMid = const Color(
    0xff000000,
  ).withAlpha((0.05 * 255).toInt());
  static const Color specificSurfaceMidMainPage = Color(0xffDBC7B8);
  static const Color specificSurfaceLow = Color(0xffFFFFFF);
  static final Color specificSurfaceExtraLow = const Color(
    0xffFFFFFF,
  ).withAlpha((0.12 * 255).toInt());
  // Border
  static const Color specificBorderMid = Color(0xffC6C6CE);
  static const Color specificBorderLow = Color(0xffDDDDE2);
  // Beige
  static const Color specificBeige10 = Color(0xffF0EBE2);
  static const Color specificBeige80 = Color(0xffB2A6A1);
  // Turquoise
  static const Color specificTurquoise60 = Color(0xff336380);
  static const Color specificTurquoise10 = Color(0xffE0E8EC);
  // Olive
  static const Color specificOlive60 = Color(0xff687B4F);
  static const Color specificOlive10 = Color(0xffF0F2ED);
  // Mustard
  static const Color specificMustardSixty = Color(0xffD2AF04);
  // Icon
  static const Color iconBlack = Color(0xff12131A);

  // Colors Primaries
  static const Color primaryAzulClaro = Color(0xFF71DBFF);
  static const Color primaryAzulSuave = Color(0xFF83F3EA);
  static const Color primaryVerdeAzulado = Color(0xFF12EB93);
  static const Color primaryVerdeMedio = Color(0xFFCCFFE2);
  static const Color primaryNaranja = Color(0xFFFFCE2B);
  static const Color primaryAmarillo = Color(0xFFFEFF00);

  // Custom Colors
  static const Color customVerde = Color(0xFF4BFFB6);
  static const Color customAzul = Color(0xFF5DE2F4);

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [
      primaryAzulSuave,
      primaryAzulClaro,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient gradientSecondary = LinearGradient(
    colors: [
      primaryVerdeAzulado,
      primaryVerdeMedio,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient gradientTertiary = LinearGradient(
    colors: [
      primaryAmarillo,
      primaryNaranja,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

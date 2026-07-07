part of 'config_imports.dart';

class AppColors {
  static const Color main = Color(0xFF1C1C1C);
  static const Color primary = Color(0xFF2B3289);
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);
  static const Color forth = Color(0xFF583D82);
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color buttonColor = Color(0xFF583D82);
  static const Color buttonText = Color(0xffF7F7F8);

  static const Color scaffoldBackground = Color(0xffFFFFFF);
  static const Color border = Color(0xFFC5C6C9);
  static const Color activeBorder = Color(0xFF583D82);
  static const Color error = Color(0xFFE34D4D);
  static const Color fieldFillColor = Color(0xFFF7F7F8);
  static const Color sheetHandle = Color(0xFFE3E3E3);
  static const Color successGreen = Color(0xFF25B77B);
  static const Color ratingStar = Color(0xFFFFC529);
  static const Color secondaryHintText = Color(0xFFB1B1B1);
  static const Color subtleBackground = Color(0xFFFAFAFA);
  static const Color inputBorder = Color(0xFFE8E8E8);
  static const Color bookingHeaderGreen = Color(0xFF32B883);
  static const Color bookingPrimaryGreen = Color(0xFF2FB67F);
  static const Color bookingSportGreen = Color(0xFF21A36B);
  static const Color bookingPriceGreen = Color(0xFF20A66E);
  static const Color bookingSuccessGreen = Color(0xFF27AE72);
  static const Color bookingDangerRed = Color(0xFFC4362E);
  static const Color bookingCancelRed = Color(0xFFC20E12);
  static const Color bookingPendingYellow = Color(0xFFE2A529);
  static const Color bookingTabInactive = Color(0xFFF6F6F6);
  static const Color bookingImageFallback = Color(0xFFE8F6F0);
  static const Color bookingCodeBackground = Color(0xFFEFFFF7);
  static const Color bookingCodeText = Color(0xFF14945F);
  static const Color bookingServiceGreen = Color(0xFF2DBB82);
  static const Color bookingMutedText = Color(0xFF9B9B9B);
  static const Color bookingDivider = Color(0xFFEDEDED);
  static const Color walletGradientStart = Color(0xFF29B980);
  static const Color walletGradientEnd = Color(0xFF0F7C55);
  static const Color walletActionGreen = Color(0xFF24A86E);

  static const Color grey1 = Color(0xffDFDFDF);
  static const Color grey2 = Color(0xFFC7C7C7);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xFF1C1C1C), Color(0xFF292929)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}

extension ColorExtension on Color {
  bool get isDark => computeLuminance() < 0.5;
}

class AppColorsWithDarkMode {
  static const Color main = Color(0xFF1C1C1C);
  static const Color primary = Color(0xFF474747);
  static const Color secondary = Color(0xFF292929);
  static const Color third = Color(0xFF1F2A37);
  static const Color forth = Color(0xFF583D82);
  static const Color hintText = Color(0xFF666666);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xffFFFFFF);
  static const Color buttonColor = Color(0xFF583D82);
  static const Color buttonText = Color(0xffF7F7F8);

  static const Color scaffoldBackground = Color(0xffFFFFFF);
  static const Color border = Color(0xFFC5C6C9);
  static const Color activeBorder = Color(0xFF583D82);
  static const Color error = Color(0xFFE34D4D);

  static const Color grey1 = Color(0xffDFDFDF);
  static const Color grey2 = Color(0xFFC7C7C7);

  static const LinearGradient gradient = LinearGradient(
    colors: [Color(0xffFB3D46), Color(0xffF72E92)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  static const LinearGradient disableGradient = LinearGradient(
    colors: [grey1, grey2],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static BoxShadow containerShadow = BoxShadow(
    color: const Color(0xFFF0F0F0).withValues(alpha: 1.0),
    offset: const Offset(0, 0),
    blurRadius: 4.0,
    spreadRadius: 0.0,
  );
}

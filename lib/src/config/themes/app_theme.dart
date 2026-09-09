import 'package:flutter/material.dart';
import '../../core/extensions/material_color_extension.dart';
import '../res/config_imports.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primarySwatch: AppColors.scenarioPrimary.toMaterialColor(),
      primaryColor: AppColors.scenarioPrimary,
      colorScheme: ColorScheme.light(
        primary: AppColors.scenarioPrimary,
        secondary: AppColors.scenarioSecondary,
        error: AppColors.scenarioError,
        surface: AppColors.scenarioSurface,
        onSurface: AppColors.scenarioText,
        outline: AppColors.scenarioBorder,
      ),
      useMaterial3: true,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: ConstantManager.fontFamily,
      iconButtonTheme: _appBarIconButtonTheme(
        iconColor: AppColors.scenarioPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: AppColors.scenarioSurface,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scenarioPrimary,
        foregroundColor: AppColors.white,
        titleTextStyle: TextStyle(
          fontFamily: ConstantManager.fontFamily,
          color: AppColors.white,
          fontSize: FontSizeManager.s14,
          fontWeight: FontWeightManager.regular,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      scaffoldBackgroundColor: AppColors.scenarioBackground,
      cardColor: AppColors.scenarioSurface,
      dividerColor: AppColors.scenarioBorder,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.scenarioSurface,
        selectedItemColor: AppColors.scenarioPrimary,
        unselectedItemColor: AppColors.scenarioMuted,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
          foregroundColor: AppColors.scenarioPrimary,
          minimumSize: Size(AppSize.sW30, AppSize.sH30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.sH0),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.scenarioPrimary,
        selectionColor: AppColors.scenarioPrimary.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.scenarioPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: AppColors.scenarioBorder,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primarySwatch: AppColorsWithDarkMode.primary.toMaterialColor(),
      primaryColor: AppColorsWithDarkMode.primary,
      useMaterial3: true,
      iconButtonTheme: _appBarIconButtonTheme(
        iconColor: AppColorsWithDarkMode.primary,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: AppColorsWithDarkMode.white,
      ),
      scaffoldBackgroundColor: AppColorsWithDarkMode.border,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColorsWithDarkMode.white,
        selectedItemColor: AppColorsWithDarkMode.primary,
        unselectedItemColor: AppColorsWithDarkMode.hintText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
          foregroundColor: AppColorsWithDarkMode.primary,
          minimumSize: Size(AppSize.sW30, AppSize.sH30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.sH0),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
      appBarTheme: const AppBarTheme(
        foregroundColor: AppColorsWithDarkMode.white,
        iconTheme: IconThemeData(color: AppColorsWithDarkMode.primary),
      ),
      iconTheme: const IconThemeData(color: AppColorsWithDarkMode.white),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: AppColorsWithDarkMode.border,
      ),
    );
  }

  static IconButtonThemeData _appBarIconButtonTheme({
    required Color iconColor,
  }) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: iconColor,
        backgroundColor: AppColors.transparent,
        fixedSize: Size(AppSize.sW40, AppSize.sH40),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),
      ),
    );
  }
}

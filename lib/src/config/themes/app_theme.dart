import 'package:flutter/material.dart';
import '../../core/extensions/material_color_extension.dart';
import '../res/config_imports.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      primarySwatch: AppColors.primary.toMaterialColor(),
      primaryColor: AppColors.primary,
      useMaterial3: true,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      fontFamily: ConstantManager.fontFamily,
      iconButtonTheme: _appBarIconButtonTheme(
        iconColor: AppColors.primary,
        backgroundColor: AppColors.fieldFillColor,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.hintText,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
          foregroundColor: AppColors.primary,
          minimumSize: Size(AppSize.sW30, AppSize.sH30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.sH0),
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(surfaceTintColor: Colors.transparent),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.primary,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      inputDecorationTheme: const InputDecorationTheme(
        prefixIconColor: AppColors.border,
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
        backgroundColor: AppColorsWithDarkMode.white,
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
    required Color backgroundColor,
  }) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: iconColor,
        backgroundColor: backgroundColor,
        fixedSize: Size(AppSize.sW40, AppSize.sH40),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),
      ),
    );
  }
}

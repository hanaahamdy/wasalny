import 'package:flutter/material.dart';
import '../../config/res/config_imports.dart';
import '../extensions/base_state.dart';
import '../extensions/text_style_extensions.dart';
import '../navigation/navigator.dart';

class MessageUtils {
  static void showSnackBar({
    BuildContext? context,
    required BaseStatus baseStatus,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final snackBar = SnackBar(
      duration: Duration(seconds: onAction == null ? 2 : 6),
      content: Text(message, style: const TextStyle().setWhiteColor.s11.medium),
      backgroundColor: baseStatus == BaseStatus.error
          ? AppColors.secondary
          : AppColors.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 4,
      action: actionLabel != null && onAction != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onAction,
            )
          : null,
    );
    ScaffoldMessenger.of(context ?? Go.context).showSnackBar(snackBar);
  }
}

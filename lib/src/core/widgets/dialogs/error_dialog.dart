import 'package:flutter/material.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';

Future<void> showAppErrorDialog({
  required BuildContext context,
  required String message,
  String? title,
  String? buttonText,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: AppColors.black.withValues(alpha: .5),
    builder: (_) =>
        AppErrorDialog(message: message, title: title, buttonText: buttonText),
  );
}

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({
    super.key,
    required this.message,
    this.title,
    this.buttonText,
  });

  final String message;
  final String? title;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: .12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error,
                size: 36,
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: 18),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.main,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.hintText,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.error,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(buttonText ?? LocaleKeys.errorDialogClose),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/text_style_extensions.dart';
import '../../../core/navigation/navigator.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../pickers/default_bottom_sheet.dart';

Future<dynamic> successDialog({
  required BuildContext context,
  required String title,
  String? desc,
  bool activeTimer = true,
  VoidCallback? afterSuccess,
}) {
  return showDefaultBottomSheet(
    context: context,
    child: SuccessDialogBody(
      title: title,
      desc: desc,
      activeTimer: activeTimer,
      afterSuccess: afterSuccess,
    ),
  );
}

class SuccessDialogBody extends StatefulWidget {
  final String title;
  final bool activeTimer;
  final String? desc;
  final VoidCallback? afterSuccess;

  const SuccessDialogBody({
    super.key,
    required this.title,
    required this.desc,
    required this.activeTimer,
    required this.afterSuccess,
  });

  @override
  State<SuccessDialogBody> createState() => SuccessDialogBodyState();
}

class SuccessDialogBodyState extends State<SuccessDialogBody> {
  @override
  void initState() {
    if (widget.activeTimer) {
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (!mounted) return;
        Go.back();
        widget.afterSuccess?.call();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH10,
      children: [
        Center(
          child: AppAssets.lottie.successfullOrder.lottie(
            width: context.width * .36,
            height: context.height * .14,
            fit: BoxFit.contain,
          ),
        ),
        AppSize.sH8.szH,
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle().setMainTextColor.s15.medium,
        ),

        if (widget.desc != null) ...[
          Text(
            widget.desc ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle().setSecondryColor.s12.regular,
          ),
        ],
      ],
    );
  }
}

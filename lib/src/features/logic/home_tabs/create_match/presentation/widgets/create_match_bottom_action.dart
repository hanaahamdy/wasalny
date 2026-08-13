part of '../imports/create_match_imports.dart';

class CreateMatchBottomAction extends StatelessWidget {
  final String? title;
  final bool enabled;
  final Future<void> Function() onNext;

  const CreateMatchBottomAction({
    super.key,
    this.title,
    required this.enabled,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24.w,
        16.h,
        24.w,
        16.h + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.createMatchBottomBorder),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.createMatchCardShadow,
            offset: Offset(0, -4),
            blurRadius: 6,
          ),
        ],
      ),
      child: LoadingButton(
        title: title ?? LocaleKeys.next,
        height: 56.h,
        color: AppColors.primary,
        onTap: enabled ? onNext : () async {},
        isDissabled: !enabled,
        borderRadius: 50.r,
        fontSize: 16.sp,
      ),
    );
  }
}

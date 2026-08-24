part of '../imports/view_imports.dart';

class OrderDetailsRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? customValue;
  final bool showDivider;

  const OrderDetailsRow({
    super.key,
    required this.label,
    this.value,
    this.customValue,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: showDivider
              ? const BorderSide(color: AppColors.inputBorder)
              : BorderSide.none,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW12,
          vertical: AppPadding.pH12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.secondaryHintText,
                fontSize: FontSizeManager.s10,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            const Spacer(),
            customValue ?? const SizedBox.shrink(),
            SizedBox(width: AppSize.sW10),
            Text(
              value ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.main,
                fontSize: FontSizeManager.s11,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

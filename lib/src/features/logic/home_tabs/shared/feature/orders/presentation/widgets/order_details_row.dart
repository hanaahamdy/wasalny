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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.secondaryHintText,
                  fontSize: FontSizeManager.s10,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ),
            SizedBox(width: AppSize.sW10),
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child:
                    customValue ??
                    Text(
                      value ?? '',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.main,
                        fontSize: FontSizeManager.s11,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

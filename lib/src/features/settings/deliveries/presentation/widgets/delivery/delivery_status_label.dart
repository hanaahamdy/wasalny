part of '../../imports/presentation_imports.dart';

class DeliveryStatusLabel extends StatelessWidget {
  final bool isActive;

  const DeliveryStatusLabel({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.successGreen : AppColors.hintText;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppSize.sW6,
          height: AppSize.sW6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: AppSize.sW4),
        Text(
          isActive ? LocaleKeys.active : LocaleKeys.inactive,
          style: TextStyle(color: color, fontSize: FontSizeManager.s10),
        ),
      ],
    );
  }
}

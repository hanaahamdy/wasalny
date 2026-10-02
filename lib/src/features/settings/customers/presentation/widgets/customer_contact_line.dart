part of '../imports/presentation_imports.dart';

class _CustomerContactLine extends StatelessWidget {
  final IconData icon;
  final String value;

  const _CustomerContactLine({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppSize.sW14, color: AppColors.hintText),
        SizedBox(width: AppSize.sW4),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: FontSizeManager.s10,
              fontWeight: FontWeightManager.regular,
            ),
          ),
        ),
      ],
    );
  }
}

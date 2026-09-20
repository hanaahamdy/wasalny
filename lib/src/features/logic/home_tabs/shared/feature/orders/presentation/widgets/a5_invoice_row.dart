part of '../imports/view_imports.dart';

class A5InvoiceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasized;

  const A5InvoiceRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.pH4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: emphasized
                    ? AppColors.scenarioText
                    : AppColors.scenarioMuted,
                fontSize: emphasized
                    ? FontSizeManager.s12
                    : FontSizeManager.s10,
                fontWeight: emphasized
                    ? FontWeightManager.bold
                    : FontWeightManager.regular,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: emphasized
                    ? AppColors.scenarioPrimary
                    : AppColors.scenarioText,
                fontSize: emphasized
                    ? FontSizeManager.s13
                    : FontSizeManager.s10,
                fontWeight: emphasized
                    ? FontWeightManager.bold
                    : FontWeightManager.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

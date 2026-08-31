part of '../imports/presentation_imports.dart';

class AdminSalesTable extends StatelessWidget {
  final List<AdminSaleModel> sales;

  const AdminSalesTable({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW10,
              vertical: AppPadding.pH8,
            ),
            child: Row(
              children: [
                Expanded(child: _TableHeader(LocaleKeys.orderNumber)),
                Expanded(child: _TableHeader(LocaleKeys.customerName)),
                Expanded(
                  child: _TableHeader(
                    LocaleKeys.salesAmount,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.inputBorder),
          for (var index = 0; index < sales.length; index++) ...[
            AdminSaleRow(sale: sales[index]),
            if (index < sales.length - 1)
              const Divider(height: 1, color: AppColors.inputBorder),
          ],
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String label;
  final AlignmentGeometry alignment;

  const _TableHeader(
    this.label, {
    this.alignment = AlignmentDirectional.centerStart,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.hintText,
          fontSize: FontSizeManager.s10,
          fontWeight: FontWeightManager.regular,
        ),
      ),
    );
  }
}

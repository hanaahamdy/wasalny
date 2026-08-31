part of '../imports/presentation_imports.dart';

class AdminSalesBody extends StatelessWidget {
  const AdminSalesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final sales = AdminSaleModel.samples;
    final totalSales = sales.fold<int>(0, (total, sale) => total + sale.amount);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AdminSalesSummaryCard(
                  icon: Icons.attach_money,
                  value: _formatAmount(totalSales),
                  label: LocaleKeys.totalSales,
                  showCurrency: true,
                ),
              ),
              SizedBox(width: AppSize.sW10),
              Expanded(
                child: AdminSalesSummaryCard(
                  icon: Icons.inventory_2_outlined,
                  value: sales.length.toString(),
                  label: LocaleKeys.completedOrders,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.sH12),
          AdminSalesTable(sales: sales),
          SizedBox(height: AppSize.sH10),
          const AdminSalesDeliveryTotal(amount: 180),
        ],
      ),
    );
  }
}

String _formatAmount(int amount) {
  final value = amount.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < value.length; index++) {
    if (index > 0 && (value.length - index) % 3 == 0) buffer.write(',');
    buffer.write(value[index]);
  }
  return buffer.toString();
}

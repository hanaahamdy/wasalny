part of '../imports/view_imports.dart';

class A5InvoiceCard extends StatelessWidget {
  final OrderModel order;

  const A5InvoiceCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.scenarioSurface,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.scenarioBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        children: [
          _header(),
          Padding(
            padding: EdgeInsets.all(AppPadding.pW14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _sectionTitle(LocaleKeys.customerInfo),
                A5InvoiceRow(
                  label: LocaleKeys.customerName,
                  value: order.customerName,
                ),
                A5InvoiceRow(label: LocaleKeys.phoneNumber, value: order.phone),
                A5InvoiceRow(
                  label: LocaleKeys.orderAddress,
                  value: order.address,
                ),
                A5InvoiceRow(
                  label: LocaleKeys.paymentMethod,
                  value: order.paymentMethod,
                ),
                _divider(),
                _sectionTitle(LocaleKeys.products),
                A5InvoiceRow(
                  label: LocaleKeys.productName,
                  value: order.productName,
                ),
                A5InvoiceRow(
                  label: LocaleKeys.quantity,
                  value: order.piecesCount,
                ),
                _divider(),
                _sectionTitle(LocaleKeys.notes),
                Text(
                  LocaleKeys.noNotes,
                  style: TextStyle(
                    color: AppColors.scenarioMuted,
                    fontSize: FontSizeManager.s10,
                  ),
                ),
                _divider(),
                A5InvoiceRow(label: LocaleKeys.subtotal, value: order.total),
                A5InvoiceRow(
                  label: LocaleKeys.deliveryFee,
                  value: order.deliveryFee,
                ),
                _divider(),
                A5InvoiceRow(
                  label: LocaleKeys.grandTotal,
                  value: _grandTotal,
                  emphasized: true,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: AppPadding.pH10),
            color: AppColors.scenarioBackground,
            child: Text(
              LocaleKeys.deliveryOrderManagement,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.scenarioMuted,
                fontSize: FontSizeManager.s10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() => Container(
    padding: EdgeInsets.symmetric(
      horizontal: AppPadding.pW14,
      vertical: AppPadding.pH14,
    ),
    decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: FontSizeManager.s11,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              Text(
                order.date,
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: .85),
                  fontSize: FontSizeManager.s10,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.wasalny,
              style: TextStyle(
                color: AppColors.white,
                fontSize: FontSizeManager.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            Text(
              LocaleKeys.deliveryOrderManagement,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: .85),
                fontSize: FontSizeManager.s10,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _sectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: AppPadding.pH4),
    child: Text(
      title,
      style: TextStyle(
        color: AppColors.scenarioPrimary,
        fontSize: FontSizeManager.s11,
        fontWeight: FontWeightManager.bold,
      ),
    ),
  );

  Widget _divider() => Padding(
    padding: EdgeInsets.symmetric(vertical: AppPadding.pH8),
    child: Divider(height: 1, color: AppColors.scenarioBorder),
  );

  String get _grandTotal {
    double parseAmount(String value) =>
        double.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    final total = parseAmount(order.total) + parseAmount(order.deliveryFee);
    return '${total.toStringAsFixed(2)} ${LocaleKeys.egyptianPoundShort}';
  }
}

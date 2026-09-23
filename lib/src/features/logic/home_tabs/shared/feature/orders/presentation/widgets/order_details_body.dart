part of '../imports/view_imports.dart';

class OrderDetailsBody extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    AppPadding.pW12,
                    AppPadding.pH8,
                    AppPadding.pW12,
                    AppPadding.pH20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _DetailsSectionTitle(title: LocaleKeys.orderInfo),
                      _DetailsCard(
                        children: [
                          OrderDetailsRow(
                            label: LocaleKeys.orderNumber,
                            value: order.displayOrderNumber,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.orderDate,
                            value: order.date,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.orderStatus,
                            customValue: _DetailsChip(
                              label: AdminOrderTab.created.label,
                              background:
                                  AppColors.settingsProfileIconBackground,
                              textColor: AppColors.scenarioPrimary,
                            ),
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.paymentStatus,
                            customValue: _DetailsChip(
                              label: LocaleKeys.paymentOnReceive,
                              background:
                                  AppColors.settingsProfileIconBackground,
                              textColor: AppColors.scenarioPrimary,
                            ),
                            showDivider: false,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.sH14),
                      _DetailsSectionTitle(title: LocaleKeys.customerInfo),
                      _DetailsCard(
                        children: [
                          OrderDetailsRow(
                            label: LocaleKeys.customerName,
                            value: order.customerName,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.phoneNumber,
                            value: order.phone,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.orderAddress,
                            value: order.address,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.paymentMethod,
                            value: order.paymentMethod,
                            showDivider: false,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.sH14),
                      _DetailsSectionTitle(title: LocaleKeys.dealDetails),
                      _DetailsCard(
                        children: [
                          OrderDetailsRow(
                            label: LocaleKeys.dealName,
                            value: order.productName,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.piecesCount,
                            value: order.piecesCount,
                            showDivider: false,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.sH14),
                      _DetailsSectionTitle(title: LocaleKeys.pricing),
                      _DetailsCard(
                        children: [
                          OrderDetailsRow(
                            label: LocaleKeys.returnPrice,
                            value: order.total,
                          ),
                          OrderDetailsRow(
                            label: LocaleKeys.deliveryFee,
                            value: order.deliveryFee,
                            showDivider: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsSectionTitle extends StatelessWidget {
  final String title;

  const _DetailsSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: AppPadding.pW10,
        bottom: AppPadding.pH6,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.hintText,
          fontSize: FontSizeManager.s11,
          fontWeight: FontWeightManager.regular,
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final List<Widget> children;

  const _DetailsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(children: children),
    );
  }
}

class _DetailsChip extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;

  const _DetailsChip({
    required this.label,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppCircular.r8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: FontSizeManager.s10,
          fontWeight: FontWeightManager.medium,
        ),
      ),
    );
  }
}

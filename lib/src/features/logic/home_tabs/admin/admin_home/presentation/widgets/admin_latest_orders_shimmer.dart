import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../../config/res/config_imports.dart';
import '../../../../shared/feature/orders/entity/order_model.dart';
import '../../../../shared/feature/orders/entity/order_tabs.dart';
import '../../../../shared/feature/orders/presentation/imports/view_imports.dart';
import '../../../../shared/widgets/view_all_orders_widget.dart';

class AdminLatestOrdersShimmer extends StatelessWidget {
  const AdminLatestOrdersShimmer({super.key});

  static const _placeholderOrder = OrderModel(
    id: 'ORD-0000000000000',
    customerName: 'Customer name placeholder',
    phone: '01000000000',
    address: '',
    createdAt: '10 September 2026',
    date: '10 September 2026',
    total: '000.00',
    paymentMethod: '',
    productName: 'Product placeholder',
    piecesCount: '0',
    deliveryFee: '00.00',
    adminTab: AdminOrderTab.pending,
    deliveryTab: DeliveryOrderTab.created,
    items: [],
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ViewAllOrdersWidget(title: LocaleKeys.latestOrders),
          SizedBox(height: AppSize.sH10),
          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH10),
              child: const OrderCard(order: _placeholderOrder),
            ),
          ),
        ],
      ),
    );
  }
}

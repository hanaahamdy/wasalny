part of '../imports/presentation_imports.dart';

class CustomersBody extends StatelessWidget {
  const CustomersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = <String, _Customer>{
      for (final order in OrderModel.samples)
        '${order.customerName}|${order.phone}': _Customer(
          name: order.customerName,
          phone: order.phone,
        ),
    }.values.toList();

    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH14,
      ),
      itemCount: customers.length,
      separatorBuilder: (_, _) => SizedBox(height: AppSize.sH10),
      itemBuilder: (context, index) =>
          _CustomerCard(customer: customers[index]),
    );
  }
}

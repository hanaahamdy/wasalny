part of '../imports/presentation_imports.dart';

class _CustomerCard extends StatelessWidget {
  final _Customer customer;

  const _CustomerCard({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSize.sW20,
            backgroundColor: AppColors.moreIconBackground,
            child: Text(
              customer.name.characters.first.toUpperCase(),
              style: TextStyle(
                color: AppColors.primary,
                fontSize: FontSizeManager.s14,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
          SizedBox(width: AppSize.sW12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.main,
                    fontSize: FontSizeManager.s14,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                SizedBox(height: AppSize.sH2),
                Text(
                  customer.phone,
                  style: TextStyle(
                    color: AppColors.hintText,
                    fontSize: FontSizeManager.s10,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: LocaleKeys.addOrder,
            onPressed: () => Go.to(
              CreateOrdersScreen(
                initialCustomerName: customer.name,
                initialCustomerPhone: customer.phone,
              ),
            ),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.moreIconBackground,
              foregroundColor: AppColors.primary,
            ),
            icon: const Icon(Icons.add_shopping_cart_outlined),
          ),
        ],
      ),
    );
  }
}

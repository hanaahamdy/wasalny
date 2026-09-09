part of '../imports/view_imports.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, int>(
      builder: (context, state) {
        final cubit = context.read<OrdersCubit>();
        final orders = cubit.orders;
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW20,
              vertical: AppPadding.pH20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrdersTabs(
                  tabs: cubit.tabs,
                  selectedIndex: state,
                  onChanged: cubit.selectTab,
                ),
                SizedBox(height: AppSize.sH20),
                Expanded(
                  child: orders.isEmpty
                      ? Center(
                          child: Text(
                            LocaleKeys.noItemsFound,
                            style: TextStyle(
                              color: AppColors.hintText,
                              fontSize: FontSizeManager.s14,
                              fontWeight: FontWeightManager.regular,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: orders.length,
                          separatorBuilder: (_, _) =>
                              SizedBox(height: AppSize.sH12),
                          itemBuilder: (context, index) =>
                              OrderCard(order: orders[index]),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

part of '../../imports/stadiums_imports.dart';

class _PaymentMethodsCard extends StatelessWidget {
  final ValueNotifier<String> selectedPaymentMethodNotifier;

  const _PaymentMethodsCard({required this.selectedPaymentMethodNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.stadiumsPaymentMethod,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<String>(
            valueListenable: selectedPaymentMethodNotifier,
            builder: (context, selectedPaymentMethod, _) {
              return Column(
                children: [
                  _PaymentMethodTile(
                    title: LocaleKeys.stadiumsOnlinePayment,
                    isSelected:
                        selectedPaymentMethod ==
                        LocaleKeys.stadiumsOnlinePayment,
                    onTap: () {
                      selectedPaymentMethodNotifier.value =
                          LocaleKeys.stadiumsOnlinePayment;
                    },
                  ),
                  SizedBox(height: 16.h),
                  _PaymentMethodTile(
                    title: LocaleKeys.stadiumsCashAfterPlay,
                    isSelected:
                        selectedPaymentMethod ==
                        LocaleKeys.stadiumsCashAfterPlay,
                    onTap: () {
                      selectedPaymentMethodNotifier.value =
                          LocaleKeys.stadiumsCashAfterPlay;
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

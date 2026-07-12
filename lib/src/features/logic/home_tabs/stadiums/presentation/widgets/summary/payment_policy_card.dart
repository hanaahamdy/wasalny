part of '../../imports/stadiums_imports.dart';

class _PaymentPolicyCard extends StatelessWidget {
  const _PaymentPolicyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.paymentPolicyBackground,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        AppAssets.svg.baseSvg.policyIcon.svg(),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.stadiumsPaymentPolicy,
                  style: TextStyle(
                    color: AppColors.paymentPolicyText,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  LocaleKeys.stadiumsPaymentPolicyDesc,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 13.sp,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

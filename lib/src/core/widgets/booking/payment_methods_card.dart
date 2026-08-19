import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import 'booking_payment_method.dart';

export 'booking_payment_method.dart';

class PaymentMethodsCard extends StatelessWidget {
  final String title;
  final List<BookingPaymentMethod> methods;
  final BookingPaymentMethod? selectedMethod;
  final ValueChanged<BookingPaymentMethod> onSelected;

  const PaymentMethodsCard({
    super.key,
    required this.title,
    required this.methods,
    required this.selectedMethod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 54.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          for (var index = 0; index < methods.length; index++) ...[
            PaymentMethodTile(
              title: methods[index].label,
              isSelected: selectedMethod == methods[index],
              onTap: () => onSelected(methods[index]),
            ),
            if (index < methods.length - 1) SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.fieldFillColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: SizedBox(
          height: 56.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                AppAssets.svg.baseSvg.paymentIcon.svg(
                  width: 24.r,
                  height: 24.r,
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(width: 8.w),

                const Spacer(),
                _PaymentSelectionIndicator(isSelected: isSelected),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaymentSelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const _PaymentSelectionIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      padding: EdgeInsets.all(5.r),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

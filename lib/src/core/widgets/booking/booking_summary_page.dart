import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../buttons/default_button.dart';
import '../custom_appbar.dart';
import 'booking_form_page.dart';

class BookingSummaryPage extends StatelessWidget {
  final BookingFormSource source;
  final String bookingType;
  final String dateTime;
  final String price;
  final String paymentMethod;
  final Widget stadiumPreview;
  final bool isLoading;
  final Future<void> Function() onConfirm;

  const BookingSummaryPage({
    super.key,
    required this.source,
    required this.bookingType,
    required this.dateTime,
    required this.price,
    required this.paymentMethod,
    required this.stadiumPreview,
    required this.isLoading,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: LocaleKeys.stadiumsBookingSummary),
      backgroundColor: AppColors.scaffoldBackground,
      bottomNavigationBar: _SummaryConfirmButton(
        isLoading: isLoading,
        onConfirm: onConfirm,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
        children: [
          _SummaryRow(
            label: LocaleKeys.stadiumsBookingType,
            value: bookingType,
          ),
          _SummaryRow(
            label: LocaleKeys.stadiumsBookingDateTime,
            value: dateTime,
          ),
          _SummaryRow(label: LocaleKeys.stadiumsPrice, value: price),
          _SummaryRow(
            label: LocaleKeys.stadiumsPaymentMethod,
            value: paymentMethod,
          ),
          SizedBox(height: 16.h),
          const _PaymentPolicyCard(),
          SizedBox(height: 20.h),
          stadiumPreview,
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 54.h),
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 13.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(color: AppColors.hintText, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}

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

class _SummaryConfirmButton extends StatelessWidget {
  final bool isLoading;
  final Future<void> Function() onConfirm;

  const _SummaryConfirmButton({
    required this.isLoading,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 18.h),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.contactBottomBarBorder),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.contactBottomBarShadow,
            blurRadius: 6,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: DefaultButton(
          title: LocaleKeys.stadiumsConfirm,
          height: 56.h,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28.r),
          onTap: isLoading ? null : () async => onConfirm(),
          customChild: isLoading
              ? SizedBox.square(
                  dimension: 22.r,
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 2,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

part of '../bookings_feature.dart';

class _BookingFilterTabs extends StatelessWidget {
  final BookingStatus selectedStatus;
  final ValueChanged<BookingStatus> onChanged;

  const _BookingFilterTabs({
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: BookingStatus.values.map((status) {
          final isSelected = selectedStatus == status;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(status),
              borderRadius: BorderRadius.circular(14.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.bookingPrimaryGreen
                      : AppColors.bookingTabInactive,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  status.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

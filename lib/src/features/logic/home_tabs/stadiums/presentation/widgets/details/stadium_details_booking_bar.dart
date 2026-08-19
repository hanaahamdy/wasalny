part of '../../imports/stadiums_imports.dart';

class _StadiumDetailsBookingBar extends StatelessWidget {
  final Stadium? stadium;

  const _StadiumDetailsBookingBar({required this.stadium});

  @override
  Widget build(BuildContext context) {
    return switch (stadium) {
      final stadium? => Padding(
        padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
        child: DefaultButton(
          title: LocaleKeys.stadiumsBookField,
          height: 56.h,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28.r),
          onTap: () async => Go.to(StadiumBookingView(stadium: stadium)),
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}

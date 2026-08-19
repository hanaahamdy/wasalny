part of '../imports/main_tab_screen_imports.dart';

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),

        const Spacer(),
        TextButton(
          onPressed: onViewAll,
          child: Text(
            LocaleKeys.viewAll,
            style: TextStyle(
              color: AppColors.stadiumSectionAction,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

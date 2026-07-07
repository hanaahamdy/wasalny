part of '../imports/stadiums_imports.dart';

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onViewAll,
          child: Text(
            LocaleKeys.viewAll,
            style: TextStyle(
              color: const Color(0xFF3DBB85),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

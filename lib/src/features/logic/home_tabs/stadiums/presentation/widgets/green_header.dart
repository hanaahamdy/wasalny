part of '../imports/stadiums_imports.dart';

class _GreenHeader extends StatelessWidget {
  final String title;

  const _GreenHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121.h,
      decoration: BoxDecoration(
        color: const Color(0xFF3DBB85),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
      ),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            PositionedDirectional(
              end: 22.w,
              child: IconButton(
                onPressed: () => Go.back(),
                icon: Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                  size: 24.r,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

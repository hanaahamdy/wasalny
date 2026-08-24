part of '../imports/view_imports.dart';

class IntroIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const IntroIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 7.w : 5.w,
          height: isActive ? 7.w : 5.w,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.white
                : AppColors.introInactiveIndicator,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

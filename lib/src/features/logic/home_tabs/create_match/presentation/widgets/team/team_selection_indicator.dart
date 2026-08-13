part of '../../imports/create_match_imports.dart';

class TeamSelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const TeamSelectionIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 32.r,
      height: 32.r,
      padding: EdgeInsets.all(7.r),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.createMatchHeader
            : AppColors.createMatchSelectionFill,
        shape: BoxShape.circle,
      ),
      child: isSelected
          ? const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.createMatchSelectionFill,
                shape: BoxShape.circle,
              ),
            )
          : null,
    );
  }
}

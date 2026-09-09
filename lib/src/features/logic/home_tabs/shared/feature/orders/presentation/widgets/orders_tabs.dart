part of '../imports/view_imports.dart';

class OrdersTabs extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const OrdersTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.sH44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        separatorBuilder: (_, _) => SizedBox(width: AppSize.sW8),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return InkWell(
            borderRadius: BorderRadius.circular(AppCircular.r8),
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pW16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.authTabSelected
                    : AppColors.fieldFillColor,
                borderRadius: BorderRadius.circular(AppCircular.r8),
                border: Border.all(
                  color: isSelected
                      ? AppColors.authTabSelected
                      : AppColors.inputBorder,
                ),
              ),
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.hintText,
                  fontSize: FontSizeManager.s12,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

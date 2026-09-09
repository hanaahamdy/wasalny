part of '../imports/presentation_imports.dart';

class _AdminActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AdminActionButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppPadding.pH12),
        height: AppSize.sH100,
        decoration: BoxDecoration(
          gradient: AppColors.scenarioGradient,
          borderRadius: BorderRadius.circular(AppCircular.r12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: AppSize.sW30,
              height: AppSize.sW30,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: .22),
                borderRadius: BorderRadius.circular(AppCircular.r10),
              ),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.white,
                size: AppSize.sH22,
              ),
            ),
            12.szH,
            Text(
              title,
              style: TextStyle(
                color: AppColors.white,
                fontSize: FontSizeManager.s13,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

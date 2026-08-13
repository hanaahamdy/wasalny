part of '../../imports/create_match_imports.dart';

class CreateMatchTeamCard extends StatelessWidget {
  final CreateMatchTeam team;
  final bool isSelected;
  final VoidCallback onTap;

  const CreateMatchTeamCard({
    super.key,
    required this.team,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Ink(
        height: 72.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: const [
            BoxShadow(color: AppColors.createMatchCardShadow, blurRadius: 27),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: team.imagePath.startsWith('http')
                  ? Image.network(
                      team.imagePath,
                      width: 48.r,
                      height: 48.r,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        AppAssets.images.taemLogo.path,
                        width: 48.r,
                        height: 48.r,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      team.imagePath.isEmpty
                          ? AppAssets.images.taemLogo.path
                          : team.imagePath,
                      width: 48.r,
                      height: 48.r,
                      fit: BoxFit.cover,
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  team.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  team.playersCount,
                  style: TextStyle(
                    color: AppColors.notificationText,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),

            const Spacer(),
            TeamSelectionIndicator(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

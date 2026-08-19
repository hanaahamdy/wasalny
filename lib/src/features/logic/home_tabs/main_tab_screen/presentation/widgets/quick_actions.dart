part of '../imports/main_tab_screen_imports.dart';

class _QuickActionsRow extends StatelessWidget {
  final bool canCreateTeam;
  final VoidCallback onCreateTeam;
  final VoidCallback onCreateMatch;

  const _QuickActionsRow({
    required this.canCreateTeam,
    required this.onCreateTeam,
    required this.onCreateMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 34.h),
      child: Row(
        children: [
          Expanded(
            child: _QuickActionCard(
              title: LocaleKeys.stadiumsCreateTeam,
              subtitle: LocaleKeys.stadiumsCreateTeamSubtitle,
              icon: Icons.groups_rounded,
              color: const Color(0xFF3DBB85),
              enabled: canCreateTeam,
              onTap: canCreateTeam ? onCreateTeam : null,
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: _QuickActionCard(
              title: LocaleKeys.stadiumsCreateMatch,
              subtitle: LocaleKeys.stadiumsCreateMatchSubtitle,
              icon: Icons.emoji_events_rounded,
              color: AppColors.primary,
              enabled: !canCreateTeam,
              onTap: canCreateTeam ? null : onCreateMatch,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.enabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: enabled ? color : AppColors.grey2,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.white, size: 21.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.86),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).onClick(onTap: onTap);
  }
}

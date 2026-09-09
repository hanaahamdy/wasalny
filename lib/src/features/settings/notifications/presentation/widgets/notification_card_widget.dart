part of '../imports/view_imports.dart';

class _NotificationCardWidget extends StatelessWidget {
  final NotificationEntity notificationEntity;
  const _NotificationCardWidget(this.notificationEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 96.h),
      padding: EdgeInsets.all(AppPadding.pH16),
      margin: EdgeInsets.only(bottom: AppMargin.mH16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r15),
        boxShadow: [
          BoxShadow(
            color: AppColors.notificationCardShadow,
            offset: Offset.zero,
            blurRadius: 27.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 44.w,
            height: AppSize.sH44,
            decoration: BoxDecoration(
              color: AppColors.scenarioPrimary,
              borderRadius: BorderRadius.circular(AppCircular.r12),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.notifications_active_rounded,
              color: AppColors.white,
              size: 22.r,
            ),
          ),
          SizedBox(width: AppMargin.mW12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  notificationEntity.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle().setMainTextColor.s14.medium,
                ),
                SizedBox(height: AppMargin.mH4),
                Text(
                  notificationEntity.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle()
                      .setColor(AppColors.notificationText)
                      .s12
                      .regular,
                ),
                SizedBox(height: AppMargin.mH6),
                Text(
                  notificationEntity.createdAt,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle()
                      .setColor(AppColors.notificationTimeText)
                      .s12
                      .regular,
                ),
              ],
            ),
          ),
        ],
      ),
    ).onClick(
      onTap: () => NotificationRoutes.navigateByType(notificationEntity.toMap),
    );
  }
}

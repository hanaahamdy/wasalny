part of '../imports/view_imports.dart';

class TeamRequestCardWidget extends StatelessWidget {
  final TeamPlayer player;
  final Future<void> Function() onAccept;

  const TeamRequestCardWidget({
    super.key,
    required this.player,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return _TeamCardShell(
      child: Column(
          children: [_buildPlayerInfo(), 15.h.szH, _buildActions()]),
    );
  }

  Widget _buildPlayerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _PlayerAvatar(player: player),
        10.w.szW,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              player.name,
              style: const TextStyle().setMainTextColor.s14.semiBold,
            ),
            3.h.szH,
            Text(
              player.city,
              style: const TextStyle().setHintColor.s11.regular,
            ),
          ],
        ),


      ],
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _RequestActionButton(
            title: LocaleKeys.accept,
            icon: Icons.check_rounded,
            backgroundColor: AppColors.teamHeaderAccent,
            foregroundColor: AppColors.white,
            onTap: onAccept,
          ),
        ),
        8.w.szW,
        Expanded(
          child: _RequestActionButton(
            title: LocaleKeys.reject,
            icon: Icons.close_rounded,
            backgroundColor: AppColors.teamRejectBackground,
            foregroundColor: AppColors.error,
            onTap: () async {},
          ),
        ),
      ],
    );
  }
}

class _RequestActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Future<void> Function() onTap;

  const _RequestActionButton({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r8),
      child: Container(
        height: 34.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppCircular.r8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: foregroundColor, size: 13.sp),
            6.w.szW,
            Text(
              title,
              style: const TextStyle().setColor(foregroundColor).s13.medium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final TeamPlayer player;
  final int? number;

  const _PlayerAvatar({required this.player, this.number});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: player.avatarColor,
            borderRadius: BorderRadius.circular(AppCircular.r12),
          ),
          child: Icon(
            Icons.person_rounded,
            color: AppColors.black.withValues(alpha: .55),
            size: 29.sp,
          ),
        ),
        if (number != null)
          PositionedDirectional(
            start: -5.w,
            bottom: 2.h,
            child: Container(
              width: 18.w,
              height: 18.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.teamHeaderAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                number.toString(),
                style: const TextStyle().setWhiteColor.s10.medium,
              ),
            ),
          ),
      ],
    );
  }
}

class _TeamCardShell extends StatelessWidget {
  final Widget child;

  const _TeamCardShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

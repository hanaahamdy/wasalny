part of '../imports/view_imports.dart';

class TeamMemberCardWidget extends StatelessWidget {
  final TeamPlayer player;
  final int number;

  const TeamMemberCardWidget({
    super.key,
    required this.player,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return _TeamCardShell(
      child: Row(
        children: [
          _PlayerAvatar(player: player, number: number),
          10.w.szW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle().setMainTextColor.s14.semiBold,
                  ),
                  if (player.role != null) ...[
                    _RoleBadge(title: player.role!),
                    6.w.szW,
                  ],
                ],
              ),
              3.h.szH,
              Text(
                player.city,
                style: const TextStyle().setHintColor.s11.regular,
              ),
            ],
          ),
          const Spacer(),
          _SubstituteButton(onTap: () {}),
        ],
      ),
    );
  }
}

class _SubstituteButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SubstituteButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r8),
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
        decoration: BoxDecoration(
          color: AppColors.teamSubstituteBackground,
          borderRadius: BorderRadius.circular(AppCircular.r8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.svg.baseSvg.replaceIcon.svg(),

            4.w.szW,
            Text(
              LocaleKeys.teamSubstitute,
              style: const TextStyle()
                  .setColor(AppColors.teamHeaderAccent)
                  .s11
                  .medium,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String title;

  const _RoleBadge({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.teamRoleBackground,
        borderRadius: BorderRadius.circular(AppCircular.r5),
      ),
      child: Text(
        title,
        style: const TextStyle().setColor(AppColors.teamRoleText).s10.medium,
      ),
    );
  }
}

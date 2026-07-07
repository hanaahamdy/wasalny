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
          _SubstituteButton(onTap: () {}),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (player.role != null) ...[
                    _RoleBadge(title: player.role!),
                    6.w.szW,
                  ],
                  Text(
                    player.name,
                    style: const TextStyle().setMainTextColor.s14.semiBold,
                  ),
                ],
              ),
              3.h.szH,
              Text(
                player.city,
                style: const TextStyle().setHintColor.s11.regular,
              ),
            ],
          ),
          10.w.szW,
          _PlayerAvatar(player: player, number: number),
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
          color: const Color(0xFFEAF9F2),
          borderRadius: BorderRadius.circular(AppCircular.r8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.swap_horiz_rounded,
              color: const Color(0xFF36B882),
              size: 13.sp,
            ),
            4.w.szW,
            Text(
              LocaleKeys.teamSubstitute,
              style: const TextStyle()
                  .setColor(const Color(0xFF36B882))
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
        color: const Color(0xFFFFF4D7),
        borderRadius: BorderRadius.circular(AppCircular.r5),
      ),
      child: Text(
        title,
        style: const TextStyle().setColor(const Color(0xFFC98F00)).s10.medium,
      ),
    );
  }
}

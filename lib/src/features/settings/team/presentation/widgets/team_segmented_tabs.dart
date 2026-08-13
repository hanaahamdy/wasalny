part of '../imports/view_imports.dart';

class TeamSegmentedTabs extends StatelessWidget {
  final bool showMembers;
  final ValueChanged<bool> onChanged;

  const TeamSegmentedTabs({
    super.key,
    required this.showMembers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.h,
      padding: EdgeInsets.all(AppPadding.pH6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .035),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              title: LocaleKeys.teamMembers,
              isActive: showMembers,
              onTap: () => onChanged(true),
            ),
          ),
          8.w.szW,
          Expanded(
            child: _SegmentButton(
              title: LocaleKeys.teamJoinRequests,
              isActive: !showMembers,
              onTap: () => onChanged(false),
            ),
          ),


        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppCircular.r8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF36B882) : AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r8),
        ),
        child: Text(
          title,
          style: const TextStyle()
              .setColor(isActive ? AppColors.white : AppColors.hintText)
              .s13
              .medium,
        ),
      ),
    );
  }
}

part of '../../imports/view_imports.dart';

enum _LoginTab { email, phone }

class _LoginTabs extends StatelessWidget {
  final _LoginTab selectedTab;
  final ValueChanged<_LoginTab> onChanged;

  const _LoginTabs({required this.selectedTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Row(
        children: [
          Expanded(
            child: _LoginTabButton(
              title: LocaleKeys.email,
              isSelected: selectedTab == _LoginTab.email,
              onTap: () => onChanged(_LoginTab.email),
            ),
          ),
          AppSize.sW18.szW,
          Expanded(
            child: _LoginTabButton(
              title: LocaleKeys.phoneNumber,
              isSelected: selectedTab == _LoginTab.phone,
              onTap: () => onChanged(_LoginTab.phone),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _LoginTabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.sH50,
      child: Material(
        color: isSelected
            ? AppColors.authTabSelected
            : AppColors.fieldFillColor,
        borderRadius: BorderRadius.circular(AppCircular.r15 + 1.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppCircular.r15 + 1.r),
          child: Center(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle()
                  .setColor(isSelected ? AppColors.white : AppColors.hintText)
                  .s12
                  .regular,
            ),
          ),
        ),
      ),
    );
  }
}

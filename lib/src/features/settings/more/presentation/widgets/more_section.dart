part of '../more_screen.dart';

class _MoreSection extends StatelessWidget {
  final String? title;
  final List<_MoreItem> items;

  const _MoreSection({this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.pH12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.pW8),
              child: Text(
                title!,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: FontSizeManager.s10,
                  fontWeight: FontWeightManager.regular,
                ),
              ),
            ),
            SizedBox(height: AppSize.sH6),
          ],
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.r12),
              border: Border.all(color: AppColors.inputBorder),
              boxShadow: [AppColors.containerShadow],
            ),
            child: Column(
              children: List.generate(items.length, (index) {
                return Column(
                  children: [
                    items[index],
                    if (index < items.length - 1)
                      const Divider(height: 1, color: AppColors.inputBorder),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

part of '../imports/presentation_imports.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.selectMonth,
          style: TextStyle(
            color: AppColors.main,
            fontSize: FontSizeManager.s11,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: AppSize.sH6),
        DropdownButtonFormField<String>(
          initialValue: LocaleKeys.august2026,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
              vertical: AppPadding.pH10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppCircular.r10),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppCircular.r10),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
          ),
          items: [
            DropdownMenuItem(
              value: LocaleKeys.august2026,
              child: Text(LocaleKeys.august2026),
            ),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }
}

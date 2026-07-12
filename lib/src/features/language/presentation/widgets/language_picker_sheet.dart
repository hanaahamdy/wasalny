import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/language/languages.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/text_style_extensions.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/buttons/loading_button.dart';
import '../../../../core/widgets/pickers/default_bottom_sheet.dart';

class LanguagePickerSheet extends StatefulWidget {
  const LanguagePickerSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showDefaultBottomSheet(
      context: context,
      child: const LanguagePickerSheet(),
    );
  }

  @override
  State<LanguagePickerSheet> createState() => _LanguagePickerSheetState();
}

class _LanguagePickerSheetState extends State<LanguagePickerSheet> {
  late Languages selectedLanguage = Languages.currentLanguage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageOptionTile(
            language: Languages.arabic,
            selectedLanguage: selectedLanguage,
            onTap: _selectLanguage,
          ),
          AppSize.sH12.szH,
          _LanguageOptionTile(
            language: Languages.english,
            selectedLanguage: selectedLanguage,
            onTap: _selectLanguage,
          ),
          AppSize.sH20.szH,
          LoadingButton(
            title: LocaleKeys.confirm,
            height: AppSize.sH56,
            borderRadius: AppCircular.infinity,
            color: AppColors.primary,
            onTap: () async {
              Languages.setLocaleWithContext(context, selectedLanguage);
              Go.back();
            },
          ),
        ],
      ),
    );
  }

  void _selectLanguage(Languages language) {
    setState(() => selectedLanguage = language);
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final Languages language;
  final Languages selectedLanguage;
  final ValueChanged<Languages> onTap;

  const _LanguageOptionTile({
    required this.language,
    required this.selectedLanguage,
    required this.onTap,
  });

  bool get isSelected => language == selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.fieldFillColor : AppColors.white,
      borderRadius: BorderRadius.circular(AppCircular.infinity),
      child: InkWell(
        onTap: () => onTap(language),
        borderRadius: BorderRadius.circular(AppCircular.infinity),
        child: Padding(
          padding: EdgeInsets.all(AppPadding.pW16),
          child: Row(
            children: [
              _LanguageFlag(language: language),
              AppSize.sW16.szW,
              Text(
                language == Languages.arabic ? 'العربية' : 'English',
                textAlign: TextAlign.end,
                style: const TextStyle()
                    .setColor(isSelected ? AppColors.main : AppColors.hintText)
                    .s16
                    .setFontWeight(
                      isSelected ? FontWeight.w500 : FontWeight.w400,
                    ),
              ),
              AppSize.sW16.szW,
              const Spacer(),
              _LanguageRadio(isSelected: isSelected),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageRadio extends StatelessWidget {
  final bool isSelected;

  const _LanguageRadio({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW20,
      height: AppSize.sH20,
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.secondaryHintText,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primary : AppColors.transparent,
        ),
      ),
    );
  }
}

class _LanguageFlag extends StatelessWidget {
  final Languages language;

  const _LanguageFlag({required this.language});

  @override
  Widget build(BuildContext context) {
    return language == Languages.arabic ? const _SaudiFlag() : const _UsFlag();
  }
}

class _SaudiFlag extends StatelessWidget {
  const _SaudiFlag();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: AppSize.sH24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.phoneCountryBadge,
        borderRadius: BorderRadius.circular(AppCircular.r2),
      ),
      child: Text('KSA', style: const TextStyle().setWhiteColor.s8.bold),
    );
  }
}

class _UsFlag extends StatelessWidget {
  const _UsFlag();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.w,
      height: AppSize.sH24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppCircular.r2),
        child: Column(
          children: List.generate(
            7,
            (index) => Expanded(
              child: Container(
                color: index.isEven ? AppColors.error : AppColors.white,
                child: index == 0
                    ? Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          width: AppSize.sW14,
                          color: AppColors.primary,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

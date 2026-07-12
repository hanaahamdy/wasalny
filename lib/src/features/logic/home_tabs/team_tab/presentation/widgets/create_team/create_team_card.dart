part of '../../imports/view_imports.dart';

class _CreateTeamCard extends StatelessWidget {
  final String? selectedSport;
  final List<String> sports;
  final TextEditingController teamNameController;
  final TextEditingController playersCountController;
  final File? teamImage;
  final ValueChanged<String?> onSportChanged;
  final Future<void> Function() onPickImage;
  final VoidCallback onRemoveImage;

  const _CreateTeamCard({
    required this.selectedSport,
    required this.sports,
    required this.teamNameController,
    required this.playersCountController,
    required this.teamImage,
    required this.onSportChanged,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppDropdown<String>(
            label: LocaleKeys.createTeamSportType,
            hint: LocaleKeys.createTeamSelectType,
            value: selectedSport,
            items: sports,
            itemAsString: (sport) => sport,
            onChanged: onSportChanged,
            height: 56.h,
            showSearchBox: false,
            borderRadius: BorderRadius.circular(16.r),
            validator: (value) => Validators.validateDropDown(
              value,
              fieldTitle: LocaleKeys.createTeamSportType,
            ),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            controller: teamNameController,
            title: LocaleKeys.createTeamName,
            hint: LocaleKeys.createTeamEnterName,
            isOptional: true,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            borderRadius: BorderRadius.circular(16.r),
            validator: (value) => Validators.validateEmpty(
              value,
              fieldTitle: LocaleKeys.createTeamName,
            ),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            controller: playersCountController,
            title: LocaleKeys.createTeamExpectedPlayersCount,
            hint: LocaleKeys.createTeamEnterCount,
            isOptional: true,
            textInputType: TextInputType.number,
            textInputAction: TextInputAction.done,
            borderRadius: BorderRadius.circular(16.r),
            validator: (value) => Validators.validateEmpty(
              value,
              fieldTitle: LocaleKeys.createTeamExpectedPlayersCount,
            ),
          ),
          AppSize.sH20.szH,
          _TeamImagePickerField(
            image: teamImage,
            onTap: onPickImage,
            onRemove: onRemoveImage,
          ),
        ],
      ),
    );
  }
}

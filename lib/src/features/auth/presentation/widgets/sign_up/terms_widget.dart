part of '../../imports/view_imports.dart';

class _TermsAgreementField extends StatelessWidget {
  const _TermsAgreementField();

  @override
  Widget build(BuildContext context) {
    return FormField<bool>(
      initialValue: false,
      validator: (value) =>
          value == true ? null : LocaleKeys.signUpTermsRequired,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TermsRow(
              isChecked: field.value ?? false,
              onChanged: () {
                field.didChange(!(field.value ?? false));
                if (field.hasError) field.validate();
              },
            ),
            if (field.hasError) ...[
              AppSize.sH6.szH,
              Text(
                field.errorText!,
                style: const TextStyle().setColor(AppColors.error).s12.regular,
              ),
            ],
          ],
        );
      },
    );
  }
}

class _TermsRow extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onChanged;

  const _TermsRow({required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: AppColors.fieldFillColor,
              border: Border.all(color: AppColors.hintText),
              borderRadius: BorderRadius.circular(5),
            ),
            child: isChecked
                ? const Icon(Icons.check, color: AppColors.primary, size: 18)
                : null,
          ),
          AppSize.sW8.szW,
          Flexible(
            child: Text(
              LocaleKeys.signUpTermsAgreement,
              textAlign: TextAlign.right,
              style: const TextStyle().setHintColor.s14.regular,
            ),
          ),
        ],
      ),
    );
  }
}

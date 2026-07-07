part of '../../imports/view_imports.dart';

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          LocaleKeys.signUpHeaderTitle,
          textAlign: TextAlign.right,
          style: const TextStyle().setBlackColor.s16.semiBold,
        ),
        AppSize.sH8.szH,
        Text(
          LocaleKeys.signUpSubtitle,
          textAlign: TextAlign.right,
          style: const TextStyle().setHintColor.s12.regular,
        ),
      ],
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xffEFEFEF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xff344955),
                  size: 78,
                ),
              ),
              PositionedDirectional(
                bottom: 16,
                start: 18,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color(0xff7A9691),
                    size: 17,
                  ),
                ),
              ),
            ],
          ),
        ),
        RichText(
          textDirection: TextDirection.rtl,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'صورة الشخصية ',
                style: const TextStyle().setMainTextColor.s14.medium,
              ),
              TextSpan(
                text: '( اختياري )',
                style: const TextStyle().setHintColor.s12.regular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignUpInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final bool isPassword;
  final String? Function(String?) validator;

  const _SignUpInputField({
    required this.title,
    required this.hint,
    required this.controller,
    required this.textInputAction,
    required this.validator,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      title: title,
      hint: hint,
      controller: controller,
      textInputType: textInputType,
      textInputAction: textInputAction,
      validator: validator,
      isPassword: isPassword,
      borderRadius: BorderRadius.circular(16),
      prefixIcon: prefixIcon == null
          ? null
          : Icon(prefixIcon, color: AppColors.hintText, size: 22),
    );
  }
}

class _SignUpSelectField extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SignUpSelectField({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      title: title,
      hint: value,
      controller: null,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: null,
      onTap: onTap,
      readOnly: true,
      borderRadius: BorderRadius.circular(16),
      suffixIcon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.hintText,
        size: 24,
      ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              'قررات ووافقت علي الشروط والاحكام',
              textAlign: TextAlign.right,
              style: const TextStyle().setHintColor.s14.regular,
            ),
          ),
          AppSize.sW8.szW,
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.fieldFillColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: isChecked
                ? const Icon(Icons.check, color: AppColors.primary, size: 18)
                : null,
          ),
        ],
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Go.offNamed(NamedRoutes.login),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(AppSize.sW40, AppSize.sH35),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'لدي حساب بالفعل , ',
              style: const TextStyle().setHintColor.s14.regular,
            ),
            TextSpan(
              text: LocaleKeys.login,
              style: const TextStyle()
                  .setColor(const Color(0xff012B1F))
                  .s16
                  .medium,
            ),
          ],
        ),
      ),
    );
  }
}

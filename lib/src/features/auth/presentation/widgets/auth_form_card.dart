part of '../imports/view_imports.dart';

class AuthFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String title;
  final String subtitle;
  final List<Widget> fields;
  final String buttonTitle;
  final VoidCallback onSubmit;
  final String? secondaryButtonTitle;
  final VoidCallback? onSecondarySubmit;
  final Widget footer;

  const AuthFormCard({
    super.key,
    required this.formKey,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.buttonTitle,
    required this.onSubmit,
    this.secondaryButtonTitle,
    this.onSecondarySubmit,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW20,
            vertical: AppPadding.pH28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthHeader(title: title, subtitle: subtitle),
              SizedBox(height: AppSize.sH28),
              ...fields,
              SizedBox(height: AppSize.sH24),
              DefaultButton(
                title: buttonTitle,
                onTap: onSubmit,
                height: AppSize.sH48,
                borderRadius: BorderRadius.circular(AppCircular.r8),
              ),
              if (secondaryButtonTitle != null) ...[
                SizedBox(height: AppSize.sH6),
                 Row(
                  children: [
                     Expanded(child: Divider(color: AppColors.grey1,endIndent: 10.w,)),
                    Text(LocaleKeys.or,style: const TextStyle(color: AppColors.grey2).s12.medium,),
                     Expanded(child: Divider(color: AppColors.grey1,indent: 10.w,)),
                  ],
                ),
                SizedBox(height: AppSize.sH6),
                DefaultButton(
                  title: secondaryButtonTitle,
                  onTap: onSecondarySubmit,
                  height: AppSize.sH48,
                  color: AppColors.white,
                  borderColor: AppColors.authTabSelected,
                  textColor: AppColors.authLinkText,
                  borderRadius: BorderRadius.circular(AppCircular.r8),
                ),
              ],
              SizedBox(height: AppSize.sH18),
              footer,
            ],
          ),
        ),
      ),
    );
  }
}

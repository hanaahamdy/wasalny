part of '../../imports/view_imports.dart';

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
  final File? image;
  final ValueChanged<File?> onImagePicked;

  const _AvatarPicker({required this.image, required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    final textStyle = DefaultTextStyle.of(context).style;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final image = await ImageHelper.getImageFromCameraOrDevice();
        if (image != null) {
          onImagePicked(image);
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: AppSize.sW120,
            height: AppSize.sH120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: AppSize.sH14),
                  width: AppSize.sW100,
                  height: AppSize.sH100,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: AppColors.avatarBackground,
                    shape: BoxShape.circle,
                  ),
                  child: image == null
                      ? AppAssets.svg.baseSvg.userVector.svg()
                      : Image.file(image!, fit: BoxFit.cover),
                ),
                PositionedDirectional(
                  bottom: AppSize.sH16,
                  end: AppSize.sW18,
                  child: Container(
                    width: AppSize.sW28,
                    height: AppSize.sH28,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white,
                        width: AppSize.sW2,
                      ),
                    ),
                    child: AppAssets.svg.baseSvg.camera.svg(),
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
                  text: '${LocaleKeys.signUpProfilePicture} ',
                  style: textStyle.setMainTextColor.s12.medium,
                ),
                TextSpan(
                  text: LocaleKeys.signUpOptional,
                  style: textStyle.setHintColor.s12.regular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

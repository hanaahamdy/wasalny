part of '../../imports/view_imports.dart';

class _TeamImagePickerField extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _TeamImagePickerField({
    required this.image,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.createTeamImage,
          style: const TextStyle().setMainTextColor.s14.medium,
        ),
        AppSize.sH6.szH,
        Material(
          color: AppColors.fieldFillColor,
          borderRadius: BorderRadius.circular(16.r),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Text(
                    image == null
                        ? LocaleKeys.createTeamEnterImage
                        : image!.path.split('/').last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: const TextStyle().setHintColor.s12.regular,
                  ),
                  const Spacer(),
                  AppAssets.svg.baseSvg.camera.svg(),
                ],
              ),
            ),
          ),
        ),
        if (image != null) ...[
          AppSize.sH12.szH,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: SizedBox(
              width: 88.r,
              height: 88.r,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.file(image!, fit: BoxFit.cover),
                    ),
                  ),
                  PositionedDirectional(
                    top: -8.r,
                    end: -8.r,
                    child: Material(
                      color: AppColors.white,
                      shape: const CircleBorder(),
                      elevation: 2,
                      child: InkWell(
                        onTap: onRemove,
                        customBorder: const CircleBorder(),
                        child: SizedBox(
                          width: 24.r,
                          height: 24.r,
                          child: Icon(
                            Icons.close_rounded,
                            color: AppColors.error,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/assets.gen.dart';
import '../../../config/res/config_imports.dart';
import '../../helpers/image_helper.dart';
import 'cached_image.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
    this.image,
    this.imageUrl,
    required this.onImageSelected,
    this.label,
  });

  final File? image;
  final String? imageUrl;
  final ValueChanged<File> onImageSelected;
  final Widget? label;

  Future<void> _pickImage() async {
    final selectedImage = await ImageHelper.getImageFromCameraOrDevice();
    if (selectedImage != null) onImageSelected(selectedImage);
  }

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: AppColors.avatarBackground,
      child: Padding(
        padding: EdgeInsets.only(top: 14.h),
        child: AppAssets.svg.baseSvg.userVector.svg(fit: BoxFit.cover),
      ),
    );

    return Column(
      children: [
        InkWell(
          onTap: _pickImage,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 120.r,
            height: 120.r,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: ClipOval(
                    child: image != null
                        ? Image.file(image!, fit: BoxFit.cover)
                        : (imageUrl?.isNotEmpty ?? false)
                        ? CachedImage(
                            url: imageUrl!,
                            width: 120.r,
                            height: 120.r,
                            fit: BoxFit.cover,
                            boxShape: BoxShape.circle,
                            placeHolder: fallback,
                            ignoreClick: true,
                          )
                        : fallback,
                  ),
                ),
                PositionedDirectional(
                  start: 0,
                  bottom: 20.h,
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: const BoxDecoration(
                      color: AppColors.avatarCameraIcon,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.white,
                      size: 20.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        label ??
            Text(
              LocaleKeys.signUpOptional,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
      ],
    );
  }
}

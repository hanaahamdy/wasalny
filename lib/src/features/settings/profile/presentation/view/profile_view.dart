part of '../imports/view_imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..fetchProfile(),
      child: const Scaffold(),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String userImage;

  const _ProfileAvatar({required this.userImage});

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: AppColors.avatarBackground,
      child: AppAssets.svg.baseSvg.userVector.svg(fit: BoxFit.cover),
    );

    return SizedBox(
      width: 120.r,
      height: 120.r,
      child: ClipOval(
        child: userImage.isEmpty
            ? fallback
            : CachedImage(
                url: userImage,
                width: 120.r,
                height: 120.r,
                boxShape: BoxShape.circle,
                placeHolder: fallback,
              ),
      ),
    );
  }
}

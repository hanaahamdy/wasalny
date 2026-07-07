part of '../imports/stadiums_imports.dart';

class _DetailsHero extends StatelessWidget {
  final Stadium stadium;

  const _DetailsHero({required this.stadium});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: stadium.detailImageUrl,
          height: 288.h,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const _ImageFallback(),
          errorWidget: (context, url, error) => const _ImageFallback(),
        ),
        PositionedDirectional(
          top: 58.h,
          end: 24.w,
          child: _CircleIconButton(
            icon: Icons.arrow_forward_ios_rounded,
            onTap: () => Go.back(),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Dot(active: false),
              SizedBox(width: 8.w),
              const _Dot(active: false),
              SizedBox(width: 8.w),
              const _Dot(active: true),
            ],
          ),
        ),
      ],
    );
  }
}

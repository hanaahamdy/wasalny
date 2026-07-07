part of '../imports/stadiums_imports.dart';

class _HomeHero extends StatelessWidget {
  final VoidCallback onSearchTap;

  const _HomeHero({required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 272.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1570498839593-e565b39455fc?auto=format&fit=crop&w=1200&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.04),
                const Color(0xFF00A56A).withValues(alpha: 0.74),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 54.h,
          end: 24.w,

          child: const _CircleIconButton(icon: Icons.notifications_none),
        ),
        PositionedDirectional(
          top: 52.h,
          start: 24.w,
          child: Row(
            children: [
              Container(
                height: 44.r,
                width: 44.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.stadiumsWelcomeUser,
                    style: TextStyle(color: AppColors.white, fontSize: 11.sp),
                  ),
                  Text(
                    LocaleKeys.stadiumsUserName,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
        PositionedDirectional(
          top: 132.h,
          end: 24.w,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.stadiumsHeroEyebrow}\n',
                  style: TextStyle(fontSize: 13.sp, height: 1.8),
                ),
                TextSpan(
                  text: LocaleKeys.stadiumsHeroTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        PositionedDirectional(
          start: 22.w,
          end: 22.w,
          bottom: -28.h,
          child: _SearchBox(
            readOnly: true,
            onTap: onSearchTap,
            onSearch: onSearchTap,
          ),
        ),
      ],
    );
  }
}

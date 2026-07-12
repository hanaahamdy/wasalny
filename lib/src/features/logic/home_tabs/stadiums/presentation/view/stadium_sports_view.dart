part of '../imports/stadiums_imports.dart';

class StadiumSportsView extends StatelessWidget {
  final List<SportCategory> sports;

  const StadiumSportsView({super.key, required this.sports});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.subtleBackground,
        appBar: CustomAppbar(
          title: LocaleKeys.stadiumsAvailableSports,
        ),
        body: GridView.builder(
          padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 28.h),
          itemCount: sports.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.w,
            mainAxisSpacing: 14.h,
            childAspectRatio: 1.04,
          ),
          itemBuilder: (context, index) {
            final sport = sports[index];
            return _SportGridCard(sport: sport);
          },
        ),
      ),
    );
  }
}

class _SportGridCard extends StatelessWidget {
  final SportCategory sport;

  const _SportGridCard({required this.sport});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: sport.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const _ImageFallback(),
              errorWidget: (context, url, error) => const _ImageFallback(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Text(
              sport.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

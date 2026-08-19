part of '../../imports/stadiums_imports.dart';

class _StadiumDetailsContent extends StatelessWidget {
  final Stadium stadium;

  const _StadiumDetailsContent({required this.stadium});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: StadiumDetailsHero(stadium: stadium)),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 24.h),
          sliver: SliverList.list(
            children: [
              _DetailsTitle(stadium: stadium),
              SizedBox(height: 18.h),
              Text(
                stadium.description,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: 13.sp,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      title: LocaleKeys.stadiumsHourPrice,
                      value: LocaleKeys.stadiumsRiyalAmount(
                        amount: '${stadium.price}',
                      ),
                      icon: Icons.attach_money,
                    ),
                  ),
                  SizedBox(width: 24.w),
                  Expanded(
                    child: _InfoTile(
                      title: LocaleKeys.stadiumsWorkingHours,
                      value: stadium.openHours,
                      icon: Icons.schedule,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),
              Text(
                LocaleKeys.stadiumsFacilitiesServices,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 14.h),
              _ServicesGrid(services: stadium.services),
            ],
          ),
        ),
      ],
    );
  }
}

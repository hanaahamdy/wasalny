part of '../imports/main_tab_screen_imports.dart';

class _SportsSectionShimmer extends StatelessWidget {
  const _SportsSectionShimmer();

  @override
  Widget build(BuildContext context) => Skeletonizer(
    enabled: true,
    child: SportsScroller(
      sports: List.generate(
        4,
        (_) => const SportCategory(name: 'Sport name', imageUrl: ''),
      ),
    ),
  );
}

class _StadiumsSectionShimmer extends StatelessWidget {
  const _StadiumsSectionShimmer();

  static const _stadium = Stadium(
    id: 0,
    name: 'Stadium name',
    location: 'Stadium location',
    sport: 'Football',
    price: 100,
    rating: 5,
    imageUrl: '',
    detailImageUrls: [],
    description: '',
    openHours: '',
    services: [],
  );

  @override
  Widget build(BuildContext context) => Skeletonizer(
    enabled: true,
    child: Column(
      children: List.generate(
        2,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: StadiumCard(stadium: _stadium, onDetails: () {}),
        ),
      ),
    ),
  );
}

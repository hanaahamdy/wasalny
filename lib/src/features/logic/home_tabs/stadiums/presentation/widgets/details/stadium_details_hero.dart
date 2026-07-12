part of '../../imports/stadiums_imports.dart';

class StadiumDetailsHero extends StatefulWidget {
  final Stadium stadium;

  const StadiumDetailsHero({super.key, required this.stadium});

  @override
  State<StadiumDetailsHero> createState() => _StadiumDetailsHeroState();
}

class _StadiumDetailsHeroState extends State<StadiumDetailsHero> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.stadium.detailImageUrls;

    return Stack(
      children: [
        SizedBox(
          height: 288.h,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: images[index],
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const _ImageFallback(),
                errorWidget: (context, url, error) => const _ImageFallback(),
              );
            },
          ),
        ),
        PositionedDirectional(
          top: 58.h,
          start: 24.w,
          child: const RoundBackButton(onTap: Go.back),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: _Dot(active: index == _currentIndex),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

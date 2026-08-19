part of '../../../stadiums/presentation/imports/stadiums_imports.dart';

class StadiumSportsView extends StatefulWidget {
  const StadiumSportsView({super.key});

  @override
  State<StadiumSportsView> createState() => _StadiumSportsViewState();
}

class _StadiumSportsViewState extends State<StadiumSportsView> {
  late final SportsCubit _cubit = SportsCubit()..loadSports();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.subtleBackground,
          appBar: CustomAppbar(title: LocaleKeys.stadiumsAvailableSports),
          body: BlocBuilder<SportsCubit, AsyncState<List<SportCategory>?>>(
            builder: (context, state) {
              if (state.isLoading || state.data == null) {
                return const Center(
                  child: LoadingIndicator(color: AppColors.primary),
                );
              }
              if (state.isError) {
                return _StadiumErrorView(
                  message: state.errorMessage,
                  onRetry: _cubit.loadSports,
                );
              }
              return GridView.builder(
                padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 28.h),
                itemCount: state.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 1.04,
                ),
                itemBuilder: (context, index) {
                  final sport = state.data![index];
                  return _SportGridCard(
                    sport: sport,
                    onTap: () => Go.to(StadiumSportView(sport: sport)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SportGridCard extends StatelessWidget {
  final SportCategory sport;
  final VoidCallback onTap;

  const _SportGridCard({required this.sport, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
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
      ),
    );
  }
}

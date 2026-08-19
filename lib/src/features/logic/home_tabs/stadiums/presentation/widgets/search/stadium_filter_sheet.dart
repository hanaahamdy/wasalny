part of '../../imports/stadiums_imports.dart';

class StadiumFilterSheet extends StatelessWidget {
  const StadiumFilterSheet({super.key});

  static Future<StadiumFilterParams?> show(
    BuildContext context, {
    required StadiumFilterParams initialFilters,
  }) {
    return showModalBottomSheet<StadiumFilterParams>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider(
        create: (_) =>
            StadiumFilterCubit(initialFilters: initialFilters)
              ..loadFilterData(),
        child: const StadiumFilterSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 19.h,
          bottom: 16.h + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              color: AppColors.changePhoneSheetShadow.withValues(alpha: 0.13),
              blurRadius: 42.r,
              offset: Offset(0, 30.h),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: BlocBuilder<StadiumFilterCubit, StadiumFilterState>(
            builder: (context, state) {
              final cubit = context.read<StadiumFilterCubit>();

              if (state.isLoading) {
                return SizedBox(
                  height: 420.h,
                  child: const Center(
                    child: LoadingIndicator(color: AppColors.primary),
                  ),
                );
              }

              if (state.errorMessage != null) {
                return SizedBox(
                  height: 420.h,
                  child: _StadiumErrorView(
                    message: state.errorMessage,
                    onRetry: cubit.loadFilterData,
                  ),
                );
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.changePhoneSheetHandle,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 32.h,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: cubit.clearSelections,
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            width: 32.r,
                            height: 32.r,
                            decoration: const BoxDecoration(
                              color: AppColors.fieldFillColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: AppColors.primary,
                              size: 18.r,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            LocaleKeys.stadiumsFilterSearch,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 32.r),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  AppDropdown<SportCategory>(
                    label: LocaleKeys.stadiumsSportType,
                    hint: LocaleKeys.stadiumsSelectSportType,
                    value: state.sport,
                    items: state.sports,
                    showSearchBox: false,
                    fillColor: AppColors.fieldFillColor,
                    borderRadius: BorderRadius.circular(16.r),
                    itemAsString: (sport) => sport.name,
                    onChanged: cubit.selectSport,
                  ),
                  SizedBox(height: 20.h),
                  AppDropdown<CityEntity>(
                    label: LocaleKeys.signUpCity,
                    hint: LocaleKeys.signUpSelectCity,
                    value: state.city,
                    items: state.cities,
                    showSearchBox: false,
                    fillColor: AppColors.fieldFillColor,
                    borderRadius: BorderRadius.circular(16.r),
                    itemAsString: (city) => city.name,
                    onChanged: cubit.selectCity,
                  ),
                  SizedBox(height: 20.h),
                  AppDropdown<DistrictEntity>(
                    label: LocaleKeys.location,
                    hint: LocaleKeys.stadiumsSelectLocation,
                    value: state.district,
                    items: state.districts,
                    isLoading: state.isDistrictLoading,
                    readonly: state.city == null,
                    showSearchBox: false,
                    fillColor: AppColors.fieldFillColor,
                    borderRadius: BorderRadius.circular(16.r),
                    itemAsString: (district) => district.name,
                    onChanged: cubit.selectDistrict,
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(state.filters),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.search,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

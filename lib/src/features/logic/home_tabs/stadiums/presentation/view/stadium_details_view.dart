part of '../imports/stadiums_imports.dart';

class StadiumDetailsView extends StatefulWidget {
  final int stadiumId;

  const StadiumDetailsView({super.key, required this.stadiumId});

  @override
  State<StadiumDetailsView> createState() => _StadiumDetailsViewState();
}

class _StadiumDetailsViewState extends State<StadiumDetailsView> {
  late final StadiumDetailsCubit _cubit = StadiumDetailsCubit()
    ..getStadium(widget.stadiumId);

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
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: AppColors.scaffoldBackground,
            bottomNavigationBar:
                BlocBuilder<StadiumDetailsCubit, AsyncState<Stadium?>>(
                  builder: (context, state) =>
                      _StadiumDetailsBookingBar(stadium: state.data),
                ),
            body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: BlocBuilder<StadiumDetailsCubit, AsyncState<Stadium?>>(
                builder: (context, state) => _StadiumDetailsBody(
                  state: state,
                  onRetry: () => context.read<StadiumDetailsCubit>().getStadium(
                    widget.stadiumId,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

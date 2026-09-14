part of '../../location/imports/imports.dart';

class LocationScreen extends StatefulWidget {
  final String? appBarTitle;
  final String? buttonTitle;
  final LocationModel? initialLocation;

  const LocationScreen({
    super.key,
    this.appBarTitle,
    this.buttonTitle,
    this.initialLocation,
  });

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationModel? location;

  @override
  void initState() {
    super.initState();
    location = widget.initialLocation;
    log("initial location ${location?.position?.latitude}");
  }

  @override
  Widget build(BuildContext context) {
    final bool hasInitialLocation = widget.initialLocation != null;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.appBarTitle ?? LocaleKeys.location,
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          MapWidget(
            mapHeight: double.infinity,
            onLocationSelected: (LocationModel newLocation) {
              setState(() {
                location = newLocation;
              });
            },
            initialLocation: widget.initialLocation,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW20,
              vertical: AppPadding.pH20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    color: AppColors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pW10,
                    vertical: AppPadding.pH16,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: AppSize.sH20,
                      ),
                      AppSize.sW8.szW,
                      Expanded(
                        child: Text(
                          location?.descriptiveLocation ?? '',
                          style: const TextStyle().setPrimaryColor.s14.semiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!hasInitialLocation) ...[
                  AppSize.sH14.szH,
                  DefaultButton(
                    borderRadius: BorderRadius.circular(AppCircular.r12),
                    margin: EdgeInsets.zero,
                    color: AppColors.primary,
                    fontSize: FontSizeManager.s12,
                    onTap: () => Go.back(location),
                    title: widget.buttonTitle ?? LocaleKeys.confirm,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

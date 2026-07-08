import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helpers/location_helper.dart';
import '../imports/imports.dart';

class MapWidget extends StatelessWidget {
  final double? mapHeight;
  final LocationModel? initialLocation;
  final void Function(LocationModel) onLocationSelected;

  const MapWidget({
    super.key,
    this.mapHeight,
    required this.onLocationSelected,
    this.initialLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(
        initialLocation: initialLocation,
        providerLocationCallback: onLocationSelected,
      )..getInitialPosition(),
      child: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          final mapCubit = context.read<MapCubit>();

          if (state.cameraPosition == null) {
            return const Center(child: CupertinoActivityIndicator());
          }

          return Container(
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: mapHeight ?? MediaQuery.of(context).size.height * 0.42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17.0),
            ),
            child: GoogleMap(
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: state.cameraPosition!,
              onMapCreated: mapCubit.initializeMap,
              onCameraMove: (CameraPosition position) {
                mapCubit.updateCameraPosition(position);
              },
              onTap: (LatLng location) {
                mapCubit.setMarkerOnTap(location);
              },
              markers: state.markers,
              gestureRecognizers: {
                Factory<PanGestureRecognizer>(() => PanGestureRecognizer())
              },
              mapType: MapType.terrain,
              polylines: state.polyLines,
            ),
          );
        },
      ),
    );
  }
}

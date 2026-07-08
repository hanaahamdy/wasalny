part of '../imports/imports.dart';

class MapState extends Equatable {
  final CameraPosition? cameraPosition;
  final GoogleMapController? googleMapController;
  final LocationModel? locationModel;
  final Set<Marker> markers;
  final Set<Polyline> polyLines;

  const MapState({
    this.cameraPosition,
    this.googleMapController,
    required this.locationModel,
    required this.markers,
    required this.polyLines,
  });

  factory MapState.initial() {
    return const MapState(
      cameraPosition: null,
      googleMapController: null,
      locationModel: null,
      markers: {},
      polyLines: {},
    );
  }

  MapState copyWith({
    CameraPosition? cameraPosition,
    GoogleMapController? googleMapController,
    LocationModel? locationModel,
    Set<Marker>? markers,
    Set<Polyline>? polyLines,
  }) {
    return MapState(
      cameraPosition: cameraPosition ?? this.cameraPosition,
      googleMapController: googleMapController ?? this.googleMapController,
      locationModel: locationModel ?? this.locationModel,
      markers: markers ?? this.markers,
      polyLines: polyLines ?? this.polyLines,
    );
  }

  @override
  List<Object?> get props => [cameraPosition, googleMapController, locationModel, markers, polyLines];
}

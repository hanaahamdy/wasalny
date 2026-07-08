part of '../imports/imports.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit({
    this.initialLocation,
    this.onMarkerTapped,
    this.providerLocationCallback,
  }) : super(MapState.initial());

  final LocationModel? initialLocation;
  final Function(LocationModel)? onMarkerTapped;
  final Function(LocationModel)? providerLocationCallback;

  final Completer<GoogleMapController> googleMapCompeleter =
      Completer<GoogleMapController>();

  Future<void> initializeMap(GoogleMapController controller) async {
    googleMapCompeleter.complete(controller);
    if (isClosed) return;
    emit(state.copyWith(googleMapController: controller));
  }

  void getInitialPosition() async {
    if (initialLocation != null) {
      initializeLocation(initialLocation!);
      return;
    }

    try {
      final hasPermission = await LocationHelper.checkLocationPermission();
      if (!hasPermission) {
        final granted = await LocationHelper.askForLocationPermission();
        if (!granted) return;
      }

      final position = await LocationHelper.getCurrentPosition();
      final address = await LocationHelper.getPlacemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final locationModel = LocationModel(
        position: position,
        placemark: address,
      );
      final cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19.4,
      );

      updateCameraPosition(cameraPosition, updateMap: true);
      updateLocationModel(locationModel);

      final marker = await getDefaultMarker(
        LatLng(position.latitude, position.longitude),
        title: address.name,
      );

      if (marker != null) {
        emit(state.copyWith(markers: {marker}));
      }

      providerLocationCallback?.call(locationModel);
    } catch (_) {
      return;
    }
  }

  void initializeLocation(LocationModel model) async {
    if (model.position == null) return;

    final cameraPosition = CameraPosition(
      target: LatLng(model.position!.latitude, model.position!.longitude),
      zoom: 19.4,
    );
    updateCameraPosition(cameraPosition, updateMap: true);
    updateLocationModel(model);

    final marker = await getDefaultMarker(
      LatLng(model.position!.latitude, model.position!.longitude),
    );
    if (marker != null) emit(state.copyWith(markers: {marker}));

    providerLocationCallback?.call(model);
  }

  Future<void> updateCameraPosition(CameraPosition position,
      {bool updateMap = false}) async {
    if (updateMap) {
      googleMapCompeleter.future.then((controller) {
        controller.animateCamera(CameraUpdate.newCameraPosition(position));
      });
    }
    if (isClosed) return;
    emit(state.copyWith(cameraPosition: position));
  }

  void updateLocationModel(LocationModel locationModel) async {
    if (locationModel.position == null) return;

    final address = await LocationHelper.getPlacemarkFromCoordinates(
      locationModel.position!.latitude,
      locationModel.position!.longitude,
    );

    if (isClosed) return;

    emit(state.copyWith(
      locationModel: locationModel.copyWith(placemark: address),
    ));
  }

  void setMarkerOnTap(LatLng latLng) async {
    final position = Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 100.0,
      altitude: 0.0,
      altitudeAccuracy: 1.0,
      heading: 0.0,
      headingAccuracy: 1.0,
      speed: 0.0,
      speedAccuracy: 1.0,
    );

    final marker = await getDefaultMarker(latLng);

    if (isClosed) return;

    var locationModel = LocationModel(position: position);

    emit(state.copyWith(
      markers: {?marker},
      locationModel: locationModel,
      cameraPosition: CameraPosition(target: latLng, zoom: 19.4),
    ));

    googleMapCompeleter.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 19.4),
      );
    });

    try {
      final address = await LocationHelper.getPlacemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (isClosed) return;
      final titledMarker = await getDefaultMarker(latLng, title: address.name);
      locationModel = locationModel.copyWith(placemark: address);
      if (isClosed) return;
      emit(state.copyWith(
        markers: {?titledMarker},
        locationModel: locationModel,
      ));
    } catch (_) {
      // keep the marker placed; address lookup is best-effort
    }

    providerLocationCallback?.call(locationModel);
  }

  Future<BitmapDescriptor> getResizedMarker(
      String assetPath, int width, int height) async {
    final ByteData data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    final frame = await codec.getNextFrame();
    final byteData =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }

  Future<Marker?> getDefaultMarker(LatLng position, {String? title}) async {
    try {
      return Marker(
        markerId: const MarkerId('location_marker'),
        position: position,
        infoWindow:
        title != null ? InfoWindow(title: title) : InfoWindow.noText,
      );
    } catch (e) {
      return Marker(
        markerId: const MarkerId('location_marker'),
        position: position,
        icon: BitmapDescriptor.defaultMarker, // ده default
        infoWindow:
        title != null ? InfoWindow(title: title) : InfoWindow.noText,
      );
    }
  }

  @override
  Future<void> close() {
    state.googleMapController?.dispose();
    return super.close();
  }
}

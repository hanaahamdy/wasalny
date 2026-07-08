// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/language/locale_keys.g.dart';
import '../extensions/base_state.dart';
import '../navigation/navigator.dart';
import '../widgets/custom_messages.dart';

class LocationException implements Exception {
  final String message;

  const LocationException(this.message);

  @override
  String toString() => message;
}

class LocationModel extends Equatable {
  final Position? position;
  final Placemark? placemark;
  final String? tempLocation;

  const LocationModel({
    required this.position,
    this.placemark,
    this.tempLocation,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json,
      {bool fromCache = false}) {
    return LocationModel(
      position: fromCache
          ? Position.fromMap(json['position'])
          : Position(
              longitude: double.tryParse(json['lng']) ?? 0.0,
              latitude: double.tryParse(json['lat']) ?? 0.0,
              timestamp: DateTime.now(),
              accuracy: 100.0,
              altitude: 0.0,
              altitudeAccuracy: 1.0,
              heading: 0.0,
              headingAccuracy: 1.0,
              speed: 0.0,
              speedAccuracy: 1.0,
            ),
      placemark: fromCache ? Placemark.fromMap(json['placemark']) : null,
      tempLocation: json['loction'],
    );
  }

  LocationModel copyWith({
    Position? position,
    Placemark? placemark,
    String? tempLocation,
  }) {
    return LocationModel(
      position: position ?? this.position,
      placemark: placemark ?? this.placemark,
      tempLocation: tempLocation ?? this.tempLocation,
    );
  }

  bool get isComplete => position != null && placemark != null;

  String get descriptiveLocation => placemark == null
      ? LocaleKeys.locationHere.tr()
      : [
          placemark?.country,
          placemark?.subAdministrativeArea,
          placemark?.thoroughfare
        ].join(', ');

  @override
  String toString() {
    return 'LocationModel(position: $position, placemark: $descriptiveLocation)';
  }

  Map<String, dynamic> toMap() {
    return {
      'position': position?.toJson(),
      'placemark': placemark?.toJson(),
      'tempLocation': tempLocation,
    };
  }

  @override
  List<Object?> get props => [position, placemark, tempLocation];

  factory LocationModel.fromLatLng({
    required double lat,
    required double lng,
    String? tempLocation,
  }) {
    return LocationModel(
      position: Position(
        latitude: lat,
        longitude: lng,
        timestamp: DateTime.now(),
        accuracy: 100.0,
        altitude: 0.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0,
      ),
      placemark: null,
      tempLocation: tempLocation,
    );
  }
}

class LocationHelper {
  static Future<bool> askForLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  static Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check for permissions
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final msg =
          '${LocaleKeys.locationServicesDisabled.tr()}\n${LocaleKeys.pleaseEnableLocationServicesInSettings.tr()}';
      MessageUtils.showSnackBar(
        baseStatus: BaseStatus.error,
        message: msg,
      );
      throw LocationException(msg);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  static Future<Position> getCurrentPosition() async =>
      await Geolocator.getCurrentPosition();

  static Future<Placemark> getPlacemarkFromCoordinates(
      double latitude, double longitude) async {
    setLocaleIdentifier(Go.navigatorKey.currentContext!.locale.languageCode);
    final List<Placemark> placemarks =
    await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first;
  }

  static Future<LocationModel?> getCurrentLocation() async {
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) return null;

    final position = await getCurrentPosition();
    final placemark = await getPlacemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return LocationModel(
      position: position,
      placemark: placemark,
      tempLocation: null,
    );
  }

  static String formatAddress(Placemark? placemark) {
    if (placemark == null) return '';

    return [
      placemark.country,
      placemark.subAdministrativeArea,
      placemark.thoroughfare,
    ].where((e) => e != null && e.isNotEmpty).join(', ');
  }
}

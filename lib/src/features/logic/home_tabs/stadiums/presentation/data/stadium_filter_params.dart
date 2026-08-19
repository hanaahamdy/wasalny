part of '../imports/stadiums_imports.dart';

class StadiumFilterParams {
  final SportCategory? sport;
  final CityEntity? city;
  final DistrictEntity? district;

  const StadiumFilterParams({this.sport, this.city, this.district});

  bool get hasFilters => sport != null || city != null || district != null;

  Map<String, dynamic> toQueryParameters() => {
    if (sport != null && sport!.id > 0) 'sport_id': sport!.id,
    if (city != null && city!.id > 0) 'city_id': city!.id,
    if (district != null && district!.id > 0) 'district_id': district!.id,
  };
}

part of '../../presentation/imports/stadiums_imports.dart';

Map<String, dynamic> _jsonMap(dynamic value) =>
    value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};

List<Map<String, dynamic>> _jsonList(dynamic value) => value is List
    ? value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList()
    : <Map<String, dynamic>>[];

int _jsonInt(dynamic value) => int.tryParse(value?.toString() ?? '') ?? 0;

double _jsonDouble(dynamic value) =>
    double.tryParse(value?.toString() ?? '') ?? 0;

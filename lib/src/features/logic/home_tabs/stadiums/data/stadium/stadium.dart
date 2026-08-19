part of '../../presentation/imports/stadiums_imports.dart';

class Stadium {
  final int id;
  final String name;
  final String location;
  final String sport;
  final int price;
  final double rating;
  final String imageUrl;
  final List<String> detailImageUrls;
  final String description;
  final String openHours;
  final List<StadiumService> services;

  const Stadium({
    required this.id,
    required this.name,
    required this.location,
    required this.sport,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.detailImageUrls,
    required this.description,
    required this.openHours,
    required this.services,
  });

  String get detailImageUrl =>
      detailImageUrls.isNotEmpty ? detailImageUrls.first : imageUrl;

  factory Stadium.fromListJson(Map<String, dynamic> json) {
    final location = _jsonMap(json['location']);
    final sport = _jsonMap(json['sport']);
    final image = json['image']?.toString() ?? '';
    return Stadium(
      id: _jsonInt(json['id']),
      name: json['name']?.toString() ?? '',
      location: location['address']?.toString() ?? '',
      sport: sport['name']?.toString() ?? '',
      price: _jsonInt(json['pricing']),
      rating: _jsonDouble(json['rate']),
      imageUrl: image,
      detailImageUrls: image.isEmpty ? const [] : [image],
      description: '',
      openHours: '',
      services: const [],
    );
  }

  factory Stadium.fromDetailsJson(Map<String, dynamic> json) {
    final data = _jsonMap(json['data']);
    final location = _jsonMap(data['location']);
    final sport = _jsonMap(data['sport']);
    final images = _jsonList(data['images'])
        .map((image) => (image['url'] ?? image['image'])?.toString() ?? '')
        .where((image) => image.isNotEmpty)
        .toList();
    return Stadium(
      id: _jsonInt(data['id']),
      name: data['name']?.toString() ?? '',
      location: location['address']?.toString() ?? '',
      sport: sport['name']?.toString() ?? '',
      price: _jsonInt(data['hourly_price']),
      rating: _jsonDouble(data['rating_avg']),
      imageUrl: images.isEmpty ? '' : images.first,
      detailImageUrls: images,
      description: data['description']?.toString() ?? '',
      openHours: '${data['open_time'] ?? ''} - ${data['close_time'] ?? ''}',
      services: _jsonList(data['facilities'])
          .map(
            (facility) => StadiumService(
              name: facility['name']?.toString() ?? '',
              icon: Icons.check_circle_outline_rounded,
            ),
          )
          .toList(),
    );
  }
}

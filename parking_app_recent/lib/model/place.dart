import 'package:parking_app/model/geometry.dart';

class Place {
  final String? name;
  final double? rating;
  final int? userRatingCount;
  final String? vicinity;
  final Geometry? geometry;

  Place(
      {this.geometry,
      this.name,
      this.rating,
      this.userRatingCount,
      this.vicinity});

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : geometry = parsedJson['geometry'],
        name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)? parsedJson['rating'].toDouble() : null,
        userRatingCount = (parsedJson['userRatingCount'] != null)? parsedJson['userRatingCount'] : null ,
        vicinity = parsedJson['vicinity'];
}

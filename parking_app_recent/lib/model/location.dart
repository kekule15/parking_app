class Location {
  final double lat;
  final double lng;

  Location({required this.lat,required this.lng});

  Location.fromJson(Map<String, dynamic> parsedJSon)
      : lat = parsedJSon['lat'],
        lng = parsedJSon['lng'];
}

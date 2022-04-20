import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants.dart';
import '../model/get_directions_response.dart';

class DirectionService {
  Future<Directions> getDirections(
    double startLat,
    double starteLng,
    double destinationLat,
    double destinationLng,
  ) async {
    var url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$starteLng&destination=$destinationLat,$destinationLng&key=${Constants.apiKey}';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print("My route Data ${response.body}");
      // print(url);
      return Directions.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(Constants.exceptionError);
    }
  }
}

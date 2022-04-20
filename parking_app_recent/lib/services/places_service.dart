import 'dart:convert';
import 'package:parking_app/constants.dart';
import 'package:parking_app/model/PlaceModel.dart';
import 'package:http/http.dart' as http;

import '../model/place_response_model.dart';

class PlaceService {
  Future<ParkingSpaceData> getPlaces(double lat, double lng) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=1000&types=parking&sensor=false&key=${Constants.apiKey}';
    // var uri =
    //     'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=packing&rankby=distance&key=${Constants.apiKey}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //  print("My Data ${response.body}");
      // print(url);
      return parkingSpaceDataFromJson(response.body);
    } else {
      throw Exception(Constants.exceptionError);
    }
  }
}

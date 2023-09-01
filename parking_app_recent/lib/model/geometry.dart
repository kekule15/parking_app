import 'package:parking_app/model/location.dart';

class Geometry{
  final Location? location;
  Geometry({this.location});
  Geometry.fromJson(Map<dynamic,dynamic> parsedJson):
      location = parsedJson['location'];
}
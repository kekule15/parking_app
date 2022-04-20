import 'package:geolocator/geolocator.dart';

class GeoLocatorService{
  Future<Position> getLocation() async{
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }

  Future<double> getDistance(double startLatitude,double startLongitude,double endLatitude,double endLongitude) async{
    double distance = Geolocator.distanceBetween( startLatitude, startLongitude, endLatitude, endLongitude);
    return distance;
  }
}
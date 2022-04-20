import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/model/PlaceModel.dart';

class MarkerService {
  List<Marker> getMarkers(List<PlaceModel> places) {
    var markers = [];
    places.forEach((place) {
      Marker marker = Marker(
          markerId: MarkerId(place.name),
          draggable: false,
          infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
          position: LatLng(place.lat, place.lng));
      markers.add(marker);
    });
    return markers;
  }
}

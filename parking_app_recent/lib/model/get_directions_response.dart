// // To parse this JSON data, do
// //
// //     final getDiretionResponse = getDiretionResponseFromJson(jsonString);

// import 'dart:convert';

// GetDiretionResponse getDiretionResponseFromJson(String str) => GetDiretionResponse.fromJson(json.decode(str));

// String getDiretionResponseToJson(GetDiretionResponse data) => json.encode(data.toJson());

// class GetDiretionResponse {
//     GetDiretionResponse({
//         this.geocodedWaypoints,
//         this.routes,
//         this.status,
//     });

//     final List<GeocodedWaypoint> geocodedWaypoints;
//     final List<Route> routes;
//     final String status;

//     factory GetDiretionResponse.fromJson(Map<String, dynamic> json) => GetDiretionResponse(
//         geocodedWaypoints: List<GeocodedWaypoint>.from(json["geocoded_waypoints"].map((x) => GeocodedWaypoint.fromJson(x))),
//         routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "geocoded_waypoints": List<dynamic>.from(geocodedWaypoints.map((x) => x.toJson())),
//         "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
//         "status": status,
//     };
// }

// class GeocodedWaypoint {
//     GeocodedWaypoint({
//         this.geocoderStatus,
//         this.placeId,
//         this.types,
//     });

//     final String geocoderStatus;
//     final String placeId;
//     final List<String> types;

//     factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => GeocodedWaypoint(
//         geocoderStatus: json["geocoder_status"],
//         placeId: json["place_id"],
//         types: List<String>.from(json["types"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "geocoder_status": geocoderStatus,
//         "place_id": placeId,
//         "types": List<dynamic>.from(types.map((x) => x)),
//     };
// }

// class Route {
//     Route({
//         this.bounds,
//         this.copyrights,
//         this.legs,
//         this.overviewPolyline,
//         this.summary,
//         this.warnings,
//         this.waypointOrder,
//     });

//     final LatLngBounds bounds;
//     final String copyrights;
//     final List<Leg> legs;
//     final Polyline overviewPolyline;
//     final String summary;
//     final List<dynamic> warnings;
//     final List<dynamic> waypointOrder;

//     factory Route.fromJson(Map<String, dynamic> json) => Route(
//         bounds: LatLngBounds.fromJson(json["bounds"]),
//         copyrights: json["copyrights"],
//         legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
//         overviewPolyline: Polyline.fromJson(json["overview_polyline"]),
//         summary: json["summary"],
//         warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
//         waypointOrder: List<dynamic>.from(json["waypoint_order"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "bounds": bounds.toJson(),
//         "copyrights": copyrights,
//         "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
//         "overview_polyline": overviewPolyline.toJson(),
//         "summary": summary,
//         "warnings": List<dynamic>.from(warnings.map((x) => x)),
//         "waypoint_order": List<dynamic>.from(waypointOrder.map((x) => x)),
//     };
// }

// class LatLngBounds {
//     LatLngBounds({
//         this.northeast,
//         this.southwest,
//     });

//     final Northeast northeast;
//     final Northeast southwest;

//     factory LatLngBounds.fromJson(Map<String, dynamic> json) => LatLngBounds(
//         northeast: Northeast.fromJson(json["northeast"]),
//         southwest: Northeast.fromJson(json["southwest"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "northeast": northeast.toJson(),
//         "southwest": southwest.toJson(),
//     };
// }

// class Northeast {
//     Northeast({
//         this.lat,
//         this.lng,
//     });

//     final double lat;
//     final double lng;

//     factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
//         lat: json["lat"].toDouble(),
//         lng: json["lng"].toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "lat": lat,
//         "lng": lng,
//     };
// }

// class Leg {
//     Leg({
//         this.distance,
//         this.duration,
//         this.endAddress,
//         this.endLocation,
//         this.startAddress,
//         this.startLocation,
//         this.steps,
//         this.trafficSpeedEntry,
//         this.viaWaypoint,
//     });

//     final Distance distance;
//     final Distance duration;
//     final String endAddress;
//     final Northeast endLocation;
//     final String startAddress;
//     final Northeast startLocation;
//     final List<Step> steps;
//     final List<dynamic> trafficSpeedEntry;
//     final List<dynamic> viaWaypoint;

//     factory Leg.fromJson(Map<String, dynamic> json) => Leg(
//         distance: Distance.fromJson(json["distance"]),
//         duration: Distance.fromJson(json["duration"]),
//         endAddress: json["end_address"],
//         endLocation: Northeast.fromJson(json["end_location"]),
//         startAddress: json["start_address"],
//         startLocation: Northeast.fromJson(json["start_location"]),
//         steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
//         trafficSpeedEntry: List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
//         viaWaypoint: List<dynamic>.from(json["via_waypoint"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "distance": distance.toJson(),
//         "duration": duration.toJson(),
//         "end_address": endAddress,
//         "end_location": endLocation.toJson(),
//         "start_address": startAddress,
//         "start_location": startLocation.toJson(),
//         "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
//         "traffic_speed_entry": List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
//         "via_waypoint": List<dynamic>.from(viaWaypoint.map((x) => x)),
//     };
// }

// class Distance {
//     Distance({
//         this.text,
//         this.value,
//     });

//     final String text;
//     final int value;

//     factory Distance.fromJson(Map<String, dynamic> json) => Distance(
//         text: json["text"],
//         value: json["value"],
//     );

//     Map<String, dynamic> toJson() => {
//         "text": text,
//         "value": value,
//     };
// }

// class Step {
//     Step({
//         this.distance,
//         this.duration,
//         this.endLocation,
//         this.htmlInstructions,
//         this.polyline,
//         this.startLocation,
//         this.travelMode,
//         this.maneuver,
//     });

//     final Distance distance;
//     final Distance duration;
//     final Northeast endLocation;
//     final String htmlInstructions;
//     final Polyline polyline;
//     final Northeast startLocation;
//     final String travelMode;
//     final String maneuver;

//     factory Step.fromJson(Map<String, dynamic> json) => Step(
//         distance: Distance.fromJson(json["distance"]),
//         duration: Distance.fromJson(json["duration"]),
//         endLocation: Northeast.fromJson(json["end_location"]),
//         htmlInstructions: json["html_instructions"],
//         polyline: Polyline.fromJson(json["polyline"]),
//         startLocation: Northeast.fromJson(json["start_location"]),
//         travelMode: json["travel_mode"],
//         maneuver: json["maneuver"] == null ? null : json["maneuver"],
//     );

//     Map<String, dynamic> toJson() => {
//         "distance": distance.toJson(),
//         "duration": duration.toJson(),
//         "end_location": endLocation.toJson(),
//         "html_instructions": htmlInstructions,
//         "polyline": polyline.toJson(),
//         "start_location": startLocation.toJson(),
//         "travel_mode": travelMode,
//         "maneuver": maneuver == null ? null : maneuver,
//     };
// }

// class Polyline {
//     Polyline({
//         this.points,
//     });

//     final String points;

//     factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
//         points: json["points"],
//     );

//     Map<String, dynamic> toJson() => {
//         "points": points,
//     };
// }



import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    @required this.bounds,
    @required this.polylinePoints,
    @required this.totalDistance,
    @required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map['routes'] as List).isEmpty) return null;

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    // Distance & Duration
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }

    return Directions(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/constants.dart';
import 'package:parking_app/helper/funtions.dart';
import 'package:parking_app/model/PlaceModel.dart';
import 'package:parking_app/model/map_route_data.dart';
import 'package:parking_app/model/place.dart';
import '../../model/place_response_model.dart';
import 'map_navigation.dart';
import 'package:parking_app/services/geolocator_service.dart';
import 'package:parking_app/services/marker_service.dart';
import 'package:parking_app/services/places_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController _controller;
  Future<List<Place>> futurePlaces;
  //List<Result> placesList = [];
  double distance, currentLat = 0.0, currentLng = 0.0;
  List<Result> places = [];
  Marker origin;
  int mapTypeController = 0;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
    final result = await PlaceService()
        .getPlaces(currentPosition.latitude, currentPosition.longitude);
    if (result != null) {
      setState(() {
        mydata = result;
      });
    }
  }

  ParkingSpaceData mydata;
  Position currentPosition;

  _getCameraPosition(double lat, double lng) {
    return CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat, lng),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  _moveCameraView(Position currentPosition) async {
    final GoogleMapController controller = await _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(_getCameraPosition(
        currentPosition.latitude, currentPosition.longitude)));
  }

  _mapView(BuildContext context, MarkerService markerService) {
    return (currentPosition != null)
        ? Container(
            height: 600,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                myLocationEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: true,
                mapType:
                    (mapTypeController == 0) ? MapType.normal : MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  // bearing: 192.8334901395799,
                  // tilt: 59.440717697143555,
                  zoom: 18.151926040649414,
                  target: LatLng(
                      currentPosition.latitude, currentPosition.longitude),
                ),
                markers: {
                  if (origin != null) origin,
                },
                onTap: addMarker,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                  setState(() {
                    origin = Marker(
                        markerId: MarkerId('origin'),
                        infoWindow: InfoWindow(
                          title: 'Origin',
                        ),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(currentPosition.latitude,
                            currentPosition.longitude));
                  });
                }),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  void addMarker(LatLng pos) async {
    if (origin == null) {
      setState(() {
        origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(
            title: 'Origin',
          ),
          icon: BitmapDescriptor.defaultMarker,
          position: pos,
        );
      });
    } else {
      setState(() {
        origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(
            title: 'Origin',
          ),
          icon: BitmapDescriptor.defaultMarker,
          position: pos,
        );
      });
    }
  }

  _placesListView(GeoLocatorService geoLocatorService,
      double currentLocationLatitude, double currentLocationLongitude) {
    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        maxChildSize: 0.7,
        minChildSize: 0.2,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              child: mydata == null
                  ? Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : mydata.results.isEmpty
                      ? Center(
                          child: Text('No parking space available now'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: mydata.results.length, //places.length,
                          itemBuilder: (context, index) {
                            return FutureProvider(
                              create: (context) =>
                                  geoLocatorService.getDistance(
                                currentLocationLatitude,
                                currentLocationLongitude,
                                mydata.results[index].geometry.location.lat,
                                mydata.results[index].geometry.location.lat,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                  elevation: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MapNavigation(
                                                    startLat:
                                                        currentLocationLatitude,
                                                    startLng:
                                                        currentLocationLongitude,
                                                    destinationLat: mydata
                                                        .results[index]
                                                        .geometry
                                                        .location
                                                        .lat,
                                                    destinationLng: mydata
                                                        .results[index]
                                                        .geometry
                                                        .location
                                                        .lng,
                                                    vicinity: mydata
                                                        .results[index]
                                                        .vicinity,
                                                    distance:
                                                        '${distance.round()}',
                                                  )));
                                    },
                                    leading: Icon(
                                      Icons.location_pin,
                                      color: Colors.blue,
                                      size: 50,
                                    ),
                                    title: Container(
                                      margin:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
                                      child: Text(
                                        mydata.results[index].name,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          mydata.results[index].vicinity,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Consumer<double>(
                                          builder: (context, meters, widget) {
                                            distance =
                                                (meters != null) ? meters : 0;
                                            return (meters != null)
                                                ? Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 10, 10, 10),
                                                    child: Text(
                                                        "${(meters).round()} m",
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors
                                                                .blueAccent)),
                                                  )
                                                : Container(
                                                    color: Colors.green,
                                                  );
                                          },
                                        )
                                      ],
                                    ),
                                    trailing: Icon(
                                      Icons.directions,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }));
        });
  }

  @override
  void initState() {
    _determinePosition();
    getLocation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();
    return Scaffold(
      body: (currentPosition != null)
          ? SafeArea(
              child: Stack(
                children: [
                  _mapView(context, markerService),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(10, 50, 10, 10),
                  //   child: Align(
                  //     alignment: Alignment.topCenter,
                  //     child: Card(
                  //       elevation: 2,
                  //       child: Container(
                  //         height: 60,
                  //         width: double.infinity,
                  //         padding: EdgeInsets.all(10),
                  //         child: TextField(
                  //           decoration:
                  //               InputDecoration(hintText: 'Search location'),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // PlacesAutocompleteResult(
                  //   onTap: (value) {
                  //     displayPrediction(value, searchScaffoldKey.currentState);
                  //   },
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: (geoService != null)
                        ? _placesListView(geoService, currentPosition.latitude,
                            currentPosition.longitude)
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),
            )
          : Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            mapTypeController = (mapTypeController == 0) ? 1 : 0;
          });
        },
        label: Text('Change Map'),
        icon: Icon(Icons.edit_location_sharp),
      ),
    );
    // catchError: (err, err2) {
    //   print('"first: "+ $err + " second: "+ $err2');
    // }
    // );
  }
}

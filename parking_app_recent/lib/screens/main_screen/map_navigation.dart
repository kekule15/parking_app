import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_app/model/map_route_data.dart';
import 'package:parking_app/services/get_directions.dart';

import '../../model/get_directions_response.dart';

class MapNavigation extends StatefulWidget {
  final double startLat;
  final double startLng;
  final double destinationLat;
  final double destinationLng;
  final String distance;
  final String vicinity;

  const MapNavigation(
      {Key key,
      this.startLat,
      this.startLng,
      this.destinationLat,
      this.destinationLng,
      this.distance,
      this.vicinity})
      : super(key: key);

  @override
  _MapNavigationState createState() => _MapNavigationState();
}

class _MapNavigationState extends State<MapNavigation> {
  CameraPosition _initialLocation;

  GoogleMapController mapController;
  Position _currentPosition;
  String _startAddress = '';
  String _destinationAddress = '';
  Set<Marker> markers = {};
  // Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  Marker _startMarker, _destinationMarker;
  Directions routeData;

  // final startAddressFocusNode = FocusNode();
  // final destinationAddressFocusNode = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Custom marker icon
  BitmapDescriptor icon;
  Timer timer;

  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), 'assets/icons/car_re.png')
        .then((value) => icon = value);
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => _getCurrentLocation());
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _arrowBack() {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
          child: Card(
            elevation: 2,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ));
  }

  _startNavigationButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(widget.startLat,
                  widget.startLng), //[merchantLatLong, userLatLong]
              zoom: 18,
            )),
          );
        },
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            color: Colors.blueAccent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.directions,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Start',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }

  _tripInfoLayout() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        color: Colors.white,
        child: Container(
            height: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.location_pin,
                    color: Colors.blue,
                    size: 50,
                  ),
                  title: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Your location -> ${widget.vicinity}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  subtitle: Text(
                    '${widget.distance}m',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                _startNavigationButton(),
              ],
            )),
      ),
    );
  }

  _googleMapLayout() {
    _initialLocation = CameraPosition(
        bearing: 192.8334901395799,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414,
        target: LatLng(widget.startLat, widget.startLng));

    return GoogleMap(
      markers: {
        if (_startMarker != null) _startMarker,
        if (_destinationMarker != null) _destinationMarker,
      },
      initialCameraPosition: _initialLocation,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      polylines: {
        if (routeData != null)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
            points: routeData.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      onMapCreated: (GoogleMapController controller) async {
        mapController = controller;

        _getCurrentLocation();
      },
    );
  }

  _getCurrentLocation() async {
    print('reloads');
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      final result = await DirectionService().getDirections(position.latitude,
          position.longitude, widget.destinationLat, widget.destinationLng);
      if (result != null) {
        setState(() {
          routeData = result;
        });
      }
      // print("my route data ${routeData.bounds}");
      setState(() {
        _currentPosition = position;
        mapController.animateCamera(
          routeData != null
              ? CameraUpdate.newLatLngBounds(routeData.bounds, 100.0)
              : CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(position.latitude, position.longitude),
                    zoom: 13.0,
                  ),
                ),
        );

        _startMarker = Marker(
            markerId: MarkerId('Start'),
            infoWindow: InfoWindow(
              title: 'Start',
            ),
            icon: icon,
            position:
                LatLng(_currentPosition.latitude, _currentPosition.longitude));

        _destinationMarker = Marker(
          markerId: MarkerId('Destination'),
          position: LatLng(widget.destinationLat, widget.destinationLng),
          infoWindow: InfoWindow(
            title: '${widget.vicinity}',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        );

        // _drawRoute(_currentPosition);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // if (routeData != null)
            // Positioned(
            //   top: 20.0,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(
            //       vertical: 6.0,
            //       horizontal: 12.0,
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.yellowAccent,
            //       borderRadius: BorderRadius.circular(20.0),
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.black26,
            //           offset: Offset(0, 2),
            //           blurRadius: 6.0,
            //         )
            //       ],
            //     ),
            //     child: Text(
            //       '${routeData.totalDistance}, ${routeData.totalDuration}',
            //       style: const TextStyle(
            //         fontSize: 18.0,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
            // ),
            _googleMapLayout(),
            _arrowBack(),
            _tripInfoLayout()
          ],
        ),
      ),
    );
  }
}

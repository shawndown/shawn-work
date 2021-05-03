import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';
import './data.dart';

const mainColor = const Color(0xFF4166F6);

class Navs extends StatelessWidget {
  final Data data;

  Navs({required this.data});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Navigate to ' + data.name),
        backgroundColor: mainColor,
      ),
      body: new GoogleMaps(data: data),
    );
  }
}

class GoogleMaps extends StatefulWidget {
  final Data data;
  const GoogleMaps({required this.data});

  @override
  _GoogleMaps createState() => new _GoogleMaps();
}

class _GoogleMaps extends State<GoogleMaps> {
  late GoogleMapController mapController;
  // // store current position
  // late Position _currentPosition;

  double _originLatitude = 0.0, _originLongitude = 0.0;
  double _destLatitude = 0.0, _destLongitude = 0.0;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "{INPUT YOUR GOOGLE API KEY}";

  // store current position
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    _originLatitude = _currentPosition.latitude;
    _originLongitude = _currentPosition.longitude;
    _destLatitude = widget.data.dest_latitude;
    _destLongitude = widget.data.dest_longitude;

    var mq = MediaQuery.of(context);
    return Center(
      child: SizedBox(
        width: mq.size.width,
        height: mq.size.height,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(_originLatitude, _originLongitude),
            zoom: 17,
          ),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        ),
      ),
    );
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "start",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.walking,
    );

    print(result.errorMessage);
    print(result.status);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}

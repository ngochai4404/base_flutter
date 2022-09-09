import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  static const pos =
      CameraPosition(target: LatLng(21.028511, 105.804817), zoom: 12);

  @override
  Widget build(BuildContext context) {
    Marker marker = Marker(
        markerId: MarkerId("A"), position: LatLng(21.028511, 105.804817));

    Marker markerB = Marker(
        markerId: MarkerId("B"), position: LatLng(20.996075, 105.861117));
    List<Marker> markers = [];
    markers.add(marker);
    markers.add(markerB);
    return Scaffold(
        appBar: AppBar(
          title: Text("Map Screen"),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.chevron_left)),
        ),
        body: GoogleMap(
            markers: Set<Marker>.of(markers),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _createPolylines(marker.position, markerB.position);
            },
            polylines: Set<Polyline>.of(polylines.values),
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: pos));
  }

  _createPolylines(LatLng start, LatLng destination) async {
    dynamic polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyD4l8kkp7btlK2uJyf2PnnHF_9HgNseLBA", // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.transit,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        print(LatLng(point.latitude, point.longitude));
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('hn');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    setState(() {
      polylines[id]= polyline;

    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final Set<Marker> _markers = <Marker>{};
  late GoogleMapController mapController;
  late Location location = Location();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geoFire = Geoflutterfire();

  late CameraPosition _userPosition = const CameraPosition(
    target: LatLng(-0.225219, -78.5248),
    zoom: 16,
  );

  @override
  void initState() {
    super.initState();
    _initCameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.location_on_outlined),
      title: const Text("Ubicación"),
      children: <Widget>[
        Column(
          children: [
            Stack(children: [
              SizedBox(
                height: 400.0,
                child: GoogleMap(
                  gestureRecognizers:
                      // ignore: prefer_collection_literals
                      <Factory<OneSequenceGestureRecognizer>>[
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer())
                  ].toSet(),
                  mapType: MapType.normal,
                  markers: _markers.toSet(),
                  myLocationEnabled: true,
                  initialCameraPosition: _userPosition,
                  onMapCreated: _onMapCreated,
                ),
              ),
              Positioned(
                bottom: 12,
                right: 60,
                // ignore: deprecated_member_use
                child: TextButton(
                  onPressed: _addMarker,
                  //color: Palette.color,
                  child: const Icon(
                    Icons.pin_drop_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ],
    );
  }

  _initCameraPosition() async {
    var pos = await location.getLocation();
    setState(() {
      _userPosition = CameraPosition(
        target: LatLng(pos.latitude!, pos.longitude!),
        zoom: 16,
      );
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _addMarker() async {
    var pos = await location.getLocation();

    var marker = Marker(
      markerId: MarkerId('$pos.latitude' '$pos.longitude'),
      position: LatLng(pos.latitude!, pos.longitude!),
      icon: BitmapDescriptor.defaultMarker,
    );

    GeoFirePoint point =
        geoFire.point(latitude: pos.latitude!, longitude: pos.longitude!);

    setState(() {
      _markers.add(marker);
      firestore.collection('locations').add({
        'position': point.data,
      });
    });
  }
}

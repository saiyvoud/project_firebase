import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  double? lat, lng;

  @override
  void initState() {
    // TODO: implement initState
    // getCurrentLocation();
    findLatLng();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      // await findLatLng();
      return null;
    }
  }

  Future<Null> findLatLng() async {
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat=======> $lat,lng ========>$lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: lat == null
            ? Center(child: CircularProgressIndicator())
            : GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(lat!, lng!)),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("marker1"),
                    position: LatLng(lat!, lng!),
                    draggable: true,
                    onDragEnd: (value) {
                      // value is the new position
                    },
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                  Marker(
                    markerId: const MarkerId("marker2"),
                    position:
                        const LatLng(17.97731411510943, 102.58070377658781),
                  ),
                },
              ),
      ),
    );
  }
}

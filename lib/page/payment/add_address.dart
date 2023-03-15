import 'dart:async';

import 'package:e_commerces/components/color.dart';
import 'package:e_commerces/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  double? lat, lng;
  BitmapDescriptor? myIcon;
  final form = GlobalKey<FormState>();
  TextEditingController dateTime = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController province = TextEditingController();
  final locationController = Get.put(LocationController());
  @override
  void initState() {
    loadingMap();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  loadingMap() {
    getCurrentPosition().then((value) {
      setState(() {
        lat = value.latitude;
        lng = value.longitude;
        print(value.latitude.toString() + "" + value.longitude.toString());
      });
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(),
        'assets/icons/pin.png',
      ).then((onValue) {
        myIcon = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColorWhite,
          ),
        ),
        title: Text(
          'Add Address',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColorWhite,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: form,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  controller: dateTime,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.alarm),
                    hintText: 'ວັນທີ່ຈັດສົ່ງ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ໂປຣດປ້ອນຂໍ້ມູນວັນທີ່ຈັດສົ່ງ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: village,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.map),
                    hintText: 'ບ້ານ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ໂປຣດປ້ອນຂໍ້ມູນບ້ານຢູ່";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: district,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.map),
                    hintText: 'ເມືອງ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ໂປຣດປ້ອນຂໍ້ມູນເມືອງຢູ່";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: province,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.map),
                    hintText: 'ແຂວງ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ໂປຣດປ້ອນຂໍ້ມູນແຂວງຢູ່";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height / 2.7,
                  child: lat == null
                      ? Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat!, lng!),
                            zoom: 14,
                          ),
                          compassEnabled: false,
                          myLocationEnabled: true,
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
                              icon: myIcon!,
                            ),
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (form.currentState!.validate()) {
            locationController.addLocation(
              dateTime: dateTime.text,
              village: village.text,
              district: district.text,
              province: province.text,
              lat: lat!,
              lng: lng!,
            );
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
          ),
          child: Center(
            child: Text(
              'Save',
              style: TextStyle(
                color: primaryColorWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerces/components/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/location_model.dart';

class LocationController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final locationModel = <LocationModel>[].obs;
  var locationLoading = false.obs;

  Future<void> getLocation() async {
    try {
     locationLoading(true);
      final QuerySnapshot querySnapshot =  await firestore
          .collection('location')
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();
            locationModel.clear();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        var data = querySnapshot.docs;
      
        locationModel.add(LocationModel(
          dateTime: data[i]['dateTime'],
          village: data[i]['village'],
          district: data[i]['district'],
          province: data[i]['province'],
          address: data[i]['address'],
          userId: data[i]['userId'],
        ));
          print('=======>' + data[i]['dateTime']);
      }
      locationLoading(false);
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLocation({
    required String dateTime,
    required String village,
    required String district,
    required String province,
    required double lat,
    required double lng,
  }) async {
    try {
      await firestore.collection('location').doc().set({
        "dateTime": dateTime,
        "village": village,
        "district": district,
        "province": province,
        "address": GeoPoint(lat, lng),
        "userId": auth.currentUser!.uid,
      }).then((value) {
        Get.snackbar(
          'Add',
          "Add location success",
          backgroundColor: primaryColorGreen,
          colorText: primaryColorWhite,
        );
      });
    } catch (e) {
      rethrow;
    }
  }
}

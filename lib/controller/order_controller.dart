import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerces/components/color.dart';
import 'package:e_commerces/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<void> deleteLocation() async {
    final firebaseS = await FirebaseFirestore.instance
        .collection('location')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get();
    firebaseS.docs.map((e) {
      e.reference.delete();

      print('deletLocation======>');
    });
  }

  // ignore: missing_return
  Future<void> deleteCart() async {
    final firebaseS = await FirebaseFirestore.instance
        .collection('cart')
        .where('userId', isEqualTo: auth.currentUser!.uid)
        .get();
    firebaseS.docs.map((e) {
      print('deletCart======>');
      e.reference.delete();
    });
  }

  Future<void> saveOrder({
    required OrderModel orderModel,
  }) async {
    try {
      await firestore
          .collection('order')
          .doc()
          .set(orderModel.toJson())
          .then((value) async {
        Get.snackbar(
          "Save",
          "Save Order Successful",
          backgroundColor: primaryColorGreen,
          colorText: primaryColorWhite,
        );

        await deleteCart();
        await deleteLocation();
        Get.offAllNamed('/home');
      });
    } catch (e) {
      rethrow;
    }
  }
}

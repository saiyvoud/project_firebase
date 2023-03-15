import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerces/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  final userModel = <UserModel>[].obs;
  var authLoading = false.obs;
  Future<void> getProfile() async {
    authLoading(true);
    try {
      userModel.clear();
      await firestore
          .collection('user')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        userModel.add(UserModel(
          firstName: value.data()!['firstName'],
          lastName: value.data()!['lastName'],
          email: value.data()!['email'],
          phoneNumber: value.data()!['phoneNumber'],
        ));
        authLoading(false);
        update();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> validator() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      if (user == null) {
        Get.offAllNamed("/dashboard");
      } else {
        Get.offAllNamed("/home");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut().then((value) {
        Get.offAllNamed("/dashboard");
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await firestore.collection("user").doc(value.user!.uid).set({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phoneNumber": phoneNumber,
          "password": password,
        }).then((value) {
          Get.snackbar(
            "Success",
            "Register Sucessful",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed("/home");
        });
      });
    } catch (e) {
      Get.snackbar(
        "Error Register",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar(
          "Success",
          "Login Sucessful",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed("/home");
      });
    } catch (e) {
      Get.snackbar(
        "Error Login",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

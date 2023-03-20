import 'package:e_commerces/models/cart_model.dart';
import 'package:e_commerces/models/location_model.dart';
import 'package:e_commerces/models/user_model.dart';

class OrderModel {
  final String? userId;
  final List<CartModel>? cartList;
  final List<LocationModel>? locationList;
  final List<UserModel>? userList;
  final int? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OrderModel({
    this.userId,
    this.cartList,
    this.locationList,
    this.userList,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        userId: json['userId'],
        cartList: List<CartModel>.from(
            json['cartList'].map((e) => CartModel.formJson(e))),
        locationList: List<LocationModel>.from(
            json['locationList'].map((e) => LocationModel.formJson(e))),
        userList: List<UserModel>.from(
            json['userlist'].map((e) => UserModel.formJson(e))),
        totalPrice: json['totalPrice'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "cartList": cartList!.map((x) => x.toJson()).toList(),
        "locationList": locationList!.map((e) => e.toJson()).toList(),
        "userList": userList!.map((e) => e.toJson()).toList(),
        "totalPrice": totalPrice,
        'createdAt': createdAt,
        "updatedAt": updatedAt,
      };
}

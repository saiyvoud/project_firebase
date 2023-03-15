import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  //ຮັບຄ່າມາຈາກພາຍນອກ
  final String? dateTime;
  final String? village;
  final String? district;
  final String? province;
  final String? userId;
  final GeoPoint? address;

//ເອີ້ນໃຊ້ພາຍໃນ
  LocationModel({
    this.dateTime,
    this.village,
    this.district,
    this.province,
    this.userId,
    this.address,
  });

//ເປັນການສ້າງ form ຂໍ້ມູນ json
  factory LocationModel.formJson(Map<String, dynamic> json) => LocationModel(
        dateTime: json['dateTime'],
        village: json['village'],
        district: json['district'],
        province: json['province'],
        userId: json['userId'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "village": village,
        "district": district,
        "province": province,
        "userId": userId,
        "address": address,
      };
}

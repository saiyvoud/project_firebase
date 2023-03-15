class UserModel {
  //ຮັບຄ່າມາຈາກພາຍນອກ
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? profile;

//ເອີ້ນໃຊ້ພາຍໃນ
  UserModel({
    this.firstName,
    this.lastName,
    this.profile,
    this.email,
    this.phoneNumber,
  });

//ເປັນການສ້າງ form ຂໍ້ມູນ json
  factory UserModel.formJson(Map<String, dynamic> json) => UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        profile: json['profile'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "profile": profile,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}

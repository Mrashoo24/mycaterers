import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class VendorModel {
    String? name;
  String? emailid;
  String? password;
  String? phone;
    String? country;
  String? state;
  String? city;
  String? pin;
  String? uid;
  double? rating;
  String? fullAddress;
  List? token;

  VendorModel(this.name,this.emailid, this.password, this.phone, this.country, this.state,
      this.city, this.uid, this.token, this.pin, this.rating,
      this.fullAddress);

  factory VendorModel.fromJson(Map<String, dynamic> data) {

    return VendorModel(
      data['name'],
        data['emailid'],
        data['password'],
        data['phone'],
        data['country'],
        data['state'],
        data['city'],
        data['uid'],
        data['token'],
        data['pin'],
      data['rating'],
    data['fullAddress'],
        );
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['emailid'] = this.emailid;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['pin'] = this.pin;
    data['rating'] = this.rating;
    data['fullAddress'] = this.fullAddress;

    return data;
  }
}

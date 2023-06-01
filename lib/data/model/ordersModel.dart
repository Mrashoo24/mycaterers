import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'foodModel.dart';

class OrderModel {
  String? id;
  String? uid;
  String? datetime;
  String? pincode;
  String? area;
  String? eventDate;
  String? notes;
  String? personCount;
  String? type;
  String? amount;
  bool? approved;
  String? vendor;
  String? status;
  List<FoodModel>? listoffoods;


  OrderModel(
      {this.id,
      this.uid,
      this.datetime,
      this.area,
      this.eventDate,this.pincode,this.notes,this.listoffoods,this.type,this.personCount
     ,this.amount,this.approved,this.vendor,this.status
      });

  factory OrderModel.fromJson(Map<String, dynamic> data) {

    List<FoodModel> foodList = (data['listoffoods'] as List<dynamic>)
        .map((e) => FoodModel.fromJson(e))
        .toList();

    return OrderModel(
        id: data['id'],
        uid: data['uid'],
        datetime: data['datetime'],
        area: data['area'],
        pincode: data['date'],
        eventDate: data['eventDate'],
        notes :data['notes'],
        personCount: data['personCount'],
        type :data['type'],
        listoffoods : foodList,
      amount: data['approvedAmount'],
      approved :data['approved'],
      vendor :data['approvedVendor'],
      status: data['status']


    );
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['uid'] = this.uid;
    data['datetime'] = this.datetime;
    data['area'] = this.area;
    data['eventDate'] = this.eventDate;
    data['notes'] = this.notes;
    data['pincode'] = this.pincode;
    data['type'] = this.type;
    data['personCount'] = this.personCount;
    data['approvedAmount'] = this.amount;
    data['approved'] = this.approved;
    data['approvedVendor'] = this.vendor;
    data['status'] = this.status;

    data['listoffoods'] = this.listoffoods!.map((e) => e.toJson()).toList();

    return data;
  }
}


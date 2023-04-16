import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class OrderModel {
  String? id;
  String? uid;
  String? datetime;
  String? foodlist;
  String? area;
  List<VendorQouteModel>? vendors;
  List? eventDate;



  OrderModel({this.id, this.uid, this.datetime, this.foodlist, this.area, this.eventDate,this.vendors});


  factory OrderModel.fromJson(Map<String,dynamic> data){
    return OrderModel(id:data['id'],uid: data['uid'],
       datetime: data['datetime'],foodlist: data['foodlist'], area: data['area'], eventDate: data['eventDate']
    ,vendors: data['vendors'].map((e) => VendorQouteModel.fromJson(e))
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['emailid'] = this.id;
    data['password'] = this.uid;
    data['phone'] = this.datetime;
    data['country'] = this.foodlist;
    data['state'] = this.area;
    data['city'] = this.eventDate;

    return data;
  }

}

class VendorQouteModel {
  String? name;
  String? amount;
  String? id;


  VendorQouteModel({this.id, this.name, this.amount,});


  factory VendorQouteModel.fromJson(Map<String,dynamic> data){
    return VendorQouteModel(id:data['id'],name: data['name'],
        amount: data['amount']
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['id'] = this.id;
    data['amount'] = this.amount;


    return data;
  }
}
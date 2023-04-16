import 'package:flutter/cupertino.dart';
import 'package:mycaterers/data/model/ordersModel.dart';

class OrderProvider with ChangeNotifier {

  late OrderModel _userModel;

  OrderModel get userModel => _userModel;


}
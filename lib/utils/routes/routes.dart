import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/view/homepage.dart';
import 'package:mycaterers/view/login.dart';
import 'package:mycaterers/view/qouteFoodFetails.dart';
import 'package:mycaterers/view/signup.dart';
import 'package:mycaterers/view/vendorList.dart';

import '../../view/foodSelectScreen.dart';

class Routes {

  var getRoute =
  {
    RouteNames.login: (context) => LoginPage(),
    RouteNames.home: (context) => HomePage(),
    RouteNames.signup: (context) => Signup(),
    RouteNames.vendorDetails: (context) => VendorDetails(),

    RouteNames.foodListScreen: (context) => FoodSelectScreen()
  };
}
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

  Route<dynamic> getRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case RouteNames.login :
        return MaterialPageRoute(builder: (context) => LoginPage() );
      case RouteNames.home :
        return MaterialPageRoute(builder: (context) => HomePage() );
      case RouteNames.signup :
        return MaterialPageRoute(builder: (context) => Signup() );
      case RouteNames.vendorDetails :
        return MaterialPageRoute(builder: (context) => VendorDetails() );

      case RouteNames.foodListScreen :
        return MaterialPageRoute(builder: (context) => FoodSelectScreen() );
      default :
        return MaterialPageRoute(builder: (context) => Scaffold(
          body: Container(child: Center(child: Text("NO ROUTES FOUND"),),),
        ) );

    }
  }

}
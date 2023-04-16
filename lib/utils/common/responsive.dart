import 'package:flutter/cupertino.dart';


class ResponsiveDimensions {



  static Size getHeigth(BuildContext context){

    var size = MediaQuery.of(context).size;


    return size;
  }
}
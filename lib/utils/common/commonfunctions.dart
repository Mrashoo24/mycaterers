import 'package:flutter/cupertino.dart';

class CommonFunctions{


  static bool validateForm(GlobalKey<FormState> formKey){
   return formKey.currentState!.validate();
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:mycaterers/data/model/usermodel.dart';
import 'package:mycaterers/utils/common/progress_dialog_utils.dart';
import 'package:mycaterers/utils/common/utils.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/utils/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositary/authrepo.dart';

class AuthController extends GetxController{

   UserModel? _userModel;

  UserModel? get userModel => _userModel;


  updateUser() async {
    var pref= await SharedPreferences.getInstance();

    _userModel = UserModel.fromJson(jsonDecode(pref.getString('usermodel')!));


    update();

    return  _userModel;
  }

  userSignup(UserModel userModel) async {
    ProgressDialogUtils.showProgressDialog();

    UserModel? result =  await  AuthRepo().signupEmail(userModel);

    ProgressDialogUtils.hideProgressDialog();

    print('final result = $result');

    if(result != null){

      var pref= await SharedPreferences.getInstance();

      _userModel =result;


      pref.setString('usermodel',jsonEncode( _userModel!.toJson()));


      update();

      Utils.showSuccesstoast('User Created');
      Get.toNamed(RouteNames.home);

    }else{

    }
  }

  userLogin(emailid, password) async {
    ProgressDialogUtils.showProgressDialog();

    UserModel? result =  await  AuthRepo().getLoginUser(emailid,password);

    ProgressDialogUtils.hideProgressDialog();

    print('final result = $result');

    if(result != null){
      var pref= await SharedPreferences.getInstance();

      _userModel =result;
      pref.setString('usermodel',jsonEncode( _userModel!.toJson()));

      update();

      Utils.showSuccesstoast('Logged in');
      Get.toNamed(RouteNames.home);

    }else{

    }
  }
  @override
  void onInit() {




    super.onInit();
  }


}
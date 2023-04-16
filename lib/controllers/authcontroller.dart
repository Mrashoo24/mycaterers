import 'package:flutter/cupertino.dart';
import 'package:mycaterers/data/model/usermodel.dart';
import 'package:mycaterers/utils/common/utils.dart';
import 'package:provider/provider.dart';

import '../repositary/authrepo.dart';

class AuthProvider with ChangeNotifier{

  late UserModel _userModel;

  UserModel get userModel => _userModel;




  userSignup(UserModel userModel) async {
    UserModel? result =  await  AuthRepo().signupEmail(userModel);

    print('final result = $result');

    if(result != null){

      _userModel =result;

      notifyListeners();

      Utils.showSuccesstoast('User Created');

    }else{

    }
  }

  userLogin(emailid, password) async {
    UserModel? result =  await  AuthRepo().getLoginUser(emailid,password);

    print('final result = $result');

    if(result != null){

      _userModel =result;

      notifyListeners();

      Utils.showSuccesstoast('User Created');

    }else{

    }
  }


}
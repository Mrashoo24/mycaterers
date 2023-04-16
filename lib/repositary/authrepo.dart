import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mycaterers/data/model/usermodel.dart';
import 'package:mycaterers/utils/common/utils.dart';

class AuthRepo {

  final fireInstance = FirebaseFirestore.instance;
  final fireAuth = FirebaseAuth.instance;

  Future<UserModel?> uploadUserData(UserModel userModel) async {

     try{

       await fireInstance.collection('Users').doc(userModel.uid).set(userModel.toJson());
       return userModel;

     }   catch (e){

     Utils.showErrorToast(e.toString());

     return null;

     }
  }

 Future<UserModel?> signupEmail(UserModel userModel) async {

     try{
       UserCredential userCred =  await  fireAuth.createUserWithEmailAndPassword(email: userModel.emailid!, password: userModel.password!);

       userModel.uid = userCred.user!.uid;

    UserModel? result =  await  uploadUserData(userModel);

    if(result != null){
      return result;
    }else{
      return null;
    }

     }on FirebaseAuthException catch(e){
       Utils.showErrorToast(e.message);
       return null;
     }
     catch(e){
       Utils.showErrorToast(e.toString());
       return null;

     }
  }


  Future<UserModel?> getLoginUser(email,password) async {
    try{
      UserCredential userCred =  await  fireAuth.signInWithEmailAndPassword(email: email, password: password);

     var uid = userCred.user!.uid;

      DocumentSnapshot<Map<String, dynamic>> userDoc =  await fireInstance.collection('Users').doc(uid).get();



        UserModel userModel =  UserModel.fromJson(userDoc.data()!);



      return userModel;



    }on FirebaseAuthException catch(e){
      Utils.showErrorToast(e.message);
      return null;
    }
    catch(e){
      Utils.showErrorToast(e.toString());
      return null;

    }
  }
  

}
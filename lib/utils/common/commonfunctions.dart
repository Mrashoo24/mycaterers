import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mycaterers/utils/common/utils.dart';

class CommonFunctions{

  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;

  static bool validateForm(GlobalKey<FormState> formKey){
   return formKey.currentState!.validate();
  }

  Future<DocumentReference<Map<String, dynamic>>?> insertFirebaseDoc({required String collectionName, required Map<String, dynamic> data,required String successMessage}) async {
    try{


      DocumentReference<Map<String, dynamic>> res =   await  firestore.collection(collectionName).add(data);

      return res;
      // Utils.showSuccesstoast(successMessage);

    }catch(e){
      debugPrint(e.toString());
      Utils.showErrorToast(e.toString());
      return null;
    }

  }

  Future<bool?> updateFirebaseDoc({required String collectionName, required Map<String, dynamic> data,required String successMessage,required String docid}) async {
    try{


      var res =   await  firestore.collection(collectionName)
      .doc(docid)
          .update(data);

      // Utils.showSuccesstoast(successMessage);

      return true;
    }catch(e){
      debugPrint(e.toString());
      Utils.showErrorToast(e.toString());
      return false;
    }

  }

  deleteFirebaseDoc({String? docid,collectionName}) async {
    try{


       await  firestore.collection(collectionName).doc(docid).delete();

      // Utils.showSuccesstoast(successMessage);

    }catch(e){
      debugPrint(e.toString());
      Utils.showErrorToast(e.toString());
    }
  }


}
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycaterers/controllers/authcontroller.dart';
import 'package:mycaterers/controllers/ordersController.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:provider/provider.dart';

import 'colors.dart';

class Utils {



  static navigate(String route,BuildContext context){
    Navigator.of(context).pushNamed(route);
  }

  static  showErrorToast(msg){
    Fluttertoast.showToast(msg: msg,backgroundColor: Colors.redAccent);
  }
  static  showSuccesstoast(msg){
    Fluttertoast.showToast(msg: msg);
  }
  static circularTextField(
      {required TextEditingController controller,
       FocusNode? focusnode,
      required void Function(String)? onChange,
       void Function(String?)? onSubmit,
      required String hint,
      required String label,
      required bool obsecure,
      required String? Function(String?)? validator,TextInputType keyboard = TextInputType.text,Widget? suffix,int? maxLine}) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: keyboard,
      minLines: 1,//Normal textInputField will be displayed
      maxLines: obsecure ? 1 : maxLine ,// w
      decoration: InputDecoration(
        suffix: suffix,
        labelText: label,
        hintText: hint,
        filled: true,

        fillColor: Colors.grey.shade50,
        labelStyle: TextStyle(color: korangeColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: korangeColor),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: korangeColor),
            borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: korangeColor),
            borderRadius: BorderRadius.circular(30)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30)),
      ),
      onChanged: onChange,
      onSaved: onSubmit,
      obscureText: obsecure,
      validator: validator,
    );
  }

  static circularOrangeButton(
      {required void Function()? onPressed, required String label}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return Colors.redAccent; //<-- SEE HERE
              return null; // Defer to the widget's default.
            },
          ),
          backgroundColor: MaterialStateProperty.all(korangeColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(label,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        ));
  }

  static circularGreenButton(
      {required void Function()? onPressed, required String label}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.greenAccent; //<-- SEE HERE
                return null; // Defer to the widget's default.
              },
            ),
            backgroundColor: MaterialStateProperty.all(kgreen),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(label,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        ));


  }


  static buttonGreen(String title,onPress){
    return ElevatedButton(
      onPressed: onPress,
      child: Text(title,),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kgreen)),
    );
  }

  static whatsappButton({String? name,String? number}) {
    return ElevatedButton(onPressed: (){
      FlutterOpenWhatsapp.sendSingleMessage("919653137263", "Hello this is ${name} My registered number is ${number}");

    }, child: Text('📞 Whatsapp us'),style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kgreen)
    ),);
  }




}

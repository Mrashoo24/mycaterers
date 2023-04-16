import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycaterers/utils/common/responsive.dart';

class QouteFoodDetails extends StatefulWidget {
  const QouteFoodDetails({Key? key}) : super(key: key);

  @override
  State<QouteFoodDetails> createState() => _QouteFoodDetailsState();
}

class _QouteFoodDetailsState extends State<QouteFoodDetails> {
  @override
  Widget build(BuildContext context) {

   var foods = ['Salami','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara','Angaara'];

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total Person : 100',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
                itemBuilder: (context,index){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 14,),
                      Text('Starters:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(foods.toString())

                    ],
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}

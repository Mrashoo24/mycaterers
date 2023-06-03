import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/ordersController.dart';
import 'package:mycaterers/utils/common/responsive.dart';

import '../data/model/CategoryMode.dart';
import '../data/model/foodModel.dart';

class QouteFoodDetails extends StatefulWidget {
  final List<FoodModel>? listoffoods;
  const QouteFoodDetails({Key? key, this.listoffoods}) : super(key: key);

  @override
  State<QouteFoodDetails> createState() => _QouteFoodDetailsState();
}

class _QouteFoodDetailsState extends State<QouteFoodDetails> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<OrderController>(
        init: Get.put(OrderController()),
        builder: (orderController) {

          var selectedCatList = widget.listoffoods!
              .map((e) => orderController.catList!.firstWhereOrNull(
                  (element) => e.catid!.contains(element.id)))
              .toList();

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total Person : ${orderController.selectedOrder.personCount.toString()}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedCatList.length,
                    itemBuilder: (context,index){
                      CategoryModel? cat = selectedCatList[index];


                      ///Fetching list of current cat which is in CART
                      List<FoodModel> catfoodList =   widget.listoffoods!.where((element) => element.catid!.contains(cat!.id)).toList();



                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 14,),
                          Text('${cat!.name}:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text(catfoodList.map((e) => e.name.toString()).toString())

                        ],
                      );
                    }
                ),
              )
            ],
          );
        }
      ),
    );
  }
}

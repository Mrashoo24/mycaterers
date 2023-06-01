import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/authcontroller.dart';
import 'package:mycaterers/controllers/ordersController.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:mycaterers/utils/common/qouteCard.dart';
import 'package:open_whatsapp/open_whatsapp.dart';

import '../data/model/vendorEnquiryModel.dart';
import '../data/model/vendorModel.dart';
import '../utils/common/utils.dart';

class VendorDetails extends StatefulWidget {
  const VendorDetails({Key? key}) : super(key: key);

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.put(AuthController()),
      builder: (authCOntroller) {
        return GetBuilder<OrderController>(
          init: Get.put(OrderController()),
          builder: (orderController) {
            return Scaffold(
              appBar: AppBar(title: Text('Caterers List'),actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Utils. whatsappButton(name:authCOntroller.userModel!.name,number: authCOntroller.userModel!.phone ),
                )
              ],),
              body: StreamBuilder<List<VendorQouteModel>>(
                  stream: orderController.listofVendorQoutes(orderController.selectedOrder.id),
                builder: (context, snapshot) {

                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(color: korangeAccent,),);
                  }

                  List<VendorQouteModel> vendorList = snapshot.requireData;

                  print('checlist = ${vendorList.length}');

                  return vendorList.isEmpty ? Center(child: Text('Waiting for vendors to respond\nEstimate time 1hrs',textAlign: TextAlign.center,),) :  ListView.builder(
                    itemCount: vendorList.length,
                    itemBuilder: (context,index){
                      VendorQouteModel vendorQouteModel = vendorList[index];


                      return FutureBuilder<VendorModel>(
                        future:orderController.getVendor(vendorQouteModel.vendorid),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return SizedBox();
                          }

                          VendorModel vendorModel = snapshot.requireData;

                          return buildVendorCard(orderController,vendorQouteModel,vendorModel,context);
                        }
                      );
                    },

                  );
                }
              ),
            );
          }
        );
      }
    );
  }


}

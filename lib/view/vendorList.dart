import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:mycaterers/utils/common/qouteCard.dart';

class VendorDetails extends StatefulWidget {
  const VendorDetails({Key? key}) : super(key: key);

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vendor List'),actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){}, child: Text('Referesh'),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kgreen)
          ),),
        )
      ],),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context,index){
          return buildVendorCard(VendorQouteModel(name: 'Zafi Pizza',amount: '100',id: '0'), context);
        },

      ),
    );
  }
}

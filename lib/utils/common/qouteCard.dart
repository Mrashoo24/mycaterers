import 'package:flutter/material.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/view/qouteFoodFetails.dart';

import 'colors.dart';

Card buildQouteCard(String orderNumber,String qoutecounts,String time,BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Order Number: $orderNumber'),
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    content: QouteFoodDetails(),
                  );
                });
              }, icon: Icon(Icons.remove_red_eye,color: Colors.green,))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          RichText(
              text: TextSpan(
                  style:
                  TextStyle(color: Colors.black, wordSpacing: 4),
                  text: 'Total Quotation Recieved: ',
                  children: [
                    TextSpan(
                        text: '$qoutecounts',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
          SizedBox(
            height: 8,
          ),
          // Text('Total Quotation Recieved : 02'),
          Text(
            'Time: $time',
            style: TextStyle(wordSpacing: 4),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Delete Qoutation'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {

                  Navigator.of(context).pushNamed(RouteNames.vendorDetails);


                },
                child: Text('View Qoutation'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.green)),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Card buildVendorCard(VendorQouteModel vendorQouteModel,BuildContext context) {

TextEditingController amountController = TextEditingController();

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Vendor Name: ${vendorQouteModel.name}'),

          SizedBox(
            height: 8,
          ),
          RichText(
              text: TextSpan(
                  style:
                  TextStyle(color: Colors.black, wordSpacing: 4),
                  text: 'Quoted Amount: ',
                  children: [
                    TextSpan(
                        text: '${vendorQouteModel.amount}',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
          SizedBox(
            height: 8,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {

                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      content: TextFormField(
                        controller:     amountController,
                        decoration: InputDecoration(
                            hintText: 'Enter your amount',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: korangeAccent)
                          ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: korangeAccent)
                            )
                        ),
                      ),
                    );
                  });

                },
                child: Text('Ask Discount'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {



                },
                child: Text('Confirm'),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.green)),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

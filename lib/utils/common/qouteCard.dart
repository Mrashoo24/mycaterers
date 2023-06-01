import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/ordersController.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/utils/common/commonfunctions.dart';
import 'package:mycaterers/utils/common/utils.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/view/qouteFoodFetails.dart';
import 'package:collection/collection.dart';
import '../../data/model/foodModel.dart';
import '../../data/model/vendorEnquiryModel.dart';
import '../../data/model/vendorModel.dart';
import 'colors.dart';

buildQouteCard(
    String orderNumber,
    String time,
    List<FoodModel>? listoffoods,
    OrderController orderController,
    OrderModel selectedOrder,
    BuildContext context) {
  return StreamBuilder<List<VendorQouteModel>>(
      stream: orderController.listofVendorQoutes(selectedOrder.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: korangeAccent,
            ),
          );
        }

        List<VendorQouteModel> vendorList = snapshot.requireData;
        print('checklengthvendorf = ${vendorList.length}');

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Order Number: $orderNumber'),
                    IconButton(
                        onPressed: () {
                          orderController.changeSelectedOrder(selectedOrder);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: QouteFoodDetails(
                                    listoffoods: listoffoods,
                                  ),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.green,
                        ))
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black, wordSpacing: 4),
                        text: 'Total Quotation Recieved:',
                        children: [
                      TextSpan(
                          text: ' ${vendorList.length}',
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
                        orderController.changeSelectedOrder(selectedOrder);

                        Get.toNamed(RouteNames.vendorDetails);
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
      });
}

Card buildVendorCard(
    OrderController orderController,
    VendorQouteModel vendorQouteModel,
    VendorModel vendorModel,
    BuildContext context) {
  var approvedList = vendorQouteModel.amount!
      .where((element) => element['approved'] == 'Accepted');

  var approvedAmount = approvedList.isNotEmpty
      ? approvedList.first['amount']
      : vendorQouteModel.amount!.first['amount'];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Caterers Name: ',
            style: TextStyle(color: Colors.black, wordSpacing: 4),
          ),
          Text(vendorModel.name ?? '',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 8,
          ),
          Center(
            child: RatingStars(
              value: vendorModel.rating!,
              onValueChanged: (v) {
                //
              },
              starBuilder: (index, color) => Icon(
                Icons.food_bank_outlined,
                color: color,
              ),
              starCount: 5,
              starSize: 20,
              valueLabelColor: const Color(0xff9b9b9b),
              valueLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              valueLabelRadius: 10,
              maxValue: 5,
              starSpacing: 2,
              maxValueVisibility: true,
              valueLabelVisibility: true,
              animationDuration: Duration(milliseconds: 1000),
              valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: const Color(0xffe7e8ea),
              starColor: Colors.yellow,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          RichText(
              text: TextSpan(
                  style: TextStyle(color: Colors.black, wordSpacing: 4),
                  text: 'Quoted Amount: ',
                  children: [
                TextSpan(
                    text: '₹${approvedAmount}',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
          SizedBox(
            height: 20,
          ),
          vendorQouteModel.amount!.length > 1
              ? Column(
                  children: [
                    RichText(
                        text: TextSpan(
                            style:
                                TextStyle(color: Colors.black, wordSpacing: 4),
                            text: 'Requested Amount: ',
                            children: [
                          TextSpan(
                              text:
                                  '₹${vendorQouteModel.amount!.last['amount']}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                    Text(
                        '(Status: ${vendorQouteModel.amount!.last['approved']})',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: vendorQouteModel.amount!.last['approved'] ==
                                    'Pending'
                                ? Colors.yellow.shade600
                                : vendorQouteModel.amount!.last['approved'] ==
                                        'Rejected'
                                    ? Colors.red.shade900
                                    : kgreen)),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: kgreen, wordSpacing: 4),
                              text: 'Approved Amount: ',
                              children: [
                            TextSpan(
                                text: '₹${approvedAmount}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24))
                          ])),
                    ),
                  ],
                )
              : SizedBox(
                  height: 8,
                ),
          SizedBox(
            height: 12,
          ),
          orderController.selectedOrder.vendor == vendorQouteModel.vendorid
              ? Text(
                  'YOU HAVE CONFIRMED ${vendorModel.name}\n You will recieve a callback soon',
                  style: TextStyle(color: kgreen, fontSize: 24),
                  textAlign: TextAlign.center,
                )
              : orderController.selectedOrder.amount != null &&
                      orderController.selectedOrder.vendor !=
                          vendorQouteModel.vendorid
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      Utils.circularOrangeButton(
                                          onPressed: () {
                                            if (orderController.amountController
                                                .text.isNotEmpty) {
                                              var listoFPreQouted =
                                                  vendorQouteModel.amount!;
                                              listoFPreQouted.add({
                                                'amount': orderController
                                                    .amountController.text,
                                                'approved': 'Pending',
                                                'vendor':
                                                    vendorQouteModel.vendorid
                                              });
                                              orderController.changeQouteAmount(
                                                  listoFPreQouted,
                                                  vendorQouteModel.id);
                                            }
                                          },
                                          label: 'Send')
                                    ],
                                    content: TextFormField(
                                      controller:
                                          orderController.amountController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]')),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'Enter your amount',
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: korangeAccent)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: korangeAccent)),
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
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      Utils.circularGreenButton(
                                          onPressed: () {
                                            CommonFunctions().updateFirebaseDoc(
                                                collectionName: 'enquiry',
                                                data: {
                                                  'approvedAmount':
                                                      approvedAmount.toString(),
                                                  'approvedVendor':
                                                      vendorModel.uid
                                                },
                                                successMessage: '',
                                                docid: orderController
                                                    .selectedOrder.id!);

                                            Get.back();
                                            Get.back();
                                            Utils.showSuccesstoast(
                                                'Request Sent');

                                          },
                                          label: 'Yes'),
                                      Utils.circularOrangeButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          label: 'No')
                                    ],
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            'Do you want to order from ${vendorModel.name}.\nThe Approved amount is ₹${approvedAmount}'),
                                      ],
                                    ),
                                  );
                                });
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

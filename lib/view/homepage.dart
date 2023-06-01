import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/authcontroller.dart';
import 'package:mycaterers/utils/common/responsive.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/view/pendingOrders.dart';

import '../controllers/ordersController.dart';
import '../utils/common/colors.dart';
import '../utils/common/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Get.put(AuthController()).updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.put(AuthController()),
      builder: (authController) {

            return authController.userModel == null ? SizedBox() :GetBuilder<OrderController>(
                init: Get.put(OrderController()),
                builder: (orderController) {

                  print(authController.userModel!.uid);

                  return  DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: korangeColor,
                        actions: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Utils.buttonGreen('Create Quote', () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, dialogState) {
                                        return AlertDialog(
                                          content: Container(
                                            height:
                                                ResponsiveDimensions.getHeigth(context)
                                                        .height *
                                                    0.5,
                                            width:
                                                ResponsiveDimensions.getHeigth(context)
                                                    .width,
                                            child: SingleChildScrollView(
                                              child: Form(
                                                key: orderController.formKey,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      controller: orderController
                                                          .countController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        hintText: 'No. of Person',
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:
                                                                        korangeAccent)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:
                                                                        korangeAccent)),
                                                      ),
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp('[0-9]')),
                                                      ],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Number of person required';
                                                        }
                                                      },
                                                    ),

                                                    SizedBox(
                                                      height: 40,
                                                    ),
                                                    // This goes to the build method
                                                    Text(
                                                      'Select Serving Type',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 22),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: RadioListTile(
                                                            title: Text('Normal'),
                                                            value: 1,
                                                            groupValue: orderController
                                                                .selectedRadio,
                                                            activeColor: Colors.green,
                                                            onChanged: (val) {
                                                              orderController
                                                                  .changeServeType(val);
                                                              dialogState(() {});
                                                            },
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: RadioListTile(
                                                            title: Text('Buffet'),
                                                            value: 2,
                                                            groupValue: orderController
                                                                .selectedRadio,
                                                            activeColor: Colors.blue,
                                                            onChanged: (val) {
                                                              orderController
                                                                  .changeServeType(val);

                                                              dialogState(() {});
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    InkWell(
                                                      onTap: () {
                                                        DatePicker.showDateTimePicker(
                                                          context,
                                                          showTitleActions: true,
                                                          minTime: DateTime.now()
                                                              .add(Duration(hours: 6)),
                                                          maxTime: DateTime.now()
                                                              .add(Duration(days: 360)),
                                                          onChanged: (date) {},
                                                          onConfirm: (date) {
                                                            print('confirm $date');
                                                            orderController
                                                                .changeDate(date);
                                                            dialogState(() {});
                                                          },
                                                          currentTime: DateTime.now(),
                                                        );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: korangeAccent)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              orderController
                                                                          .pickedDate ==
                                                                      null
                                                                  ? 'Select Date'
                                                                  : orderController
                                                                      .pickedDate!
                                                                      .toLocal()
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: korangeAccent),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(Icons.calendar_month)
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 20,
                                                    ),

                                                    TextFormField(
                                                      controller: orderController
                                                          .pincodeController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration: InputDecoration(
                                                        hintText: 'Pincode',
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:
                                                                        korangeAccent)),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color:
                                                                        korangeAccent)),
                                                      ),
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp('[0-9]')),
                                                      ],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Pincode required';
                                                        }
                                                      },
                                                    ),

                                                    SizedBox(
                                                      height: 20,
                                                    ),

                                                    Utils.circularTextField(
                                                      controller: orderController
                                                          .addressController,
                                                      maxLine: 5,
                                                      onChange: (value) {},
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Event Address required';
                                                        }
                                                      },
                                                      hint: 'Enter event address',
                                                      label: 'Event Address',
                                                      obsecure: false,
                                                    ),

                                                    SizedBox(
                                                      height: 20,
                                                    ),

                                                    Utils.circularTextField(
                                                      controller: orderController
                                                          .notesController,
                                                      maxLine: 5,
                                                      onChange: (value) {},
                                                      hint:
                                                          'Enter event type and other details',
                                                      label: 'Notes',
                                                      obsecure: false,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Some comments required';
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                    ),
                                                    Utils.buttonGreen('Proceed', () {
                                                      // if (orderController
                                                      //     .checkFormValidation()) {
                                                      Get.toNamed(
                                                          RouteNames.foodListScreen);
                                                      // }
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              }))
                        ],
                        bottom: TabBar(
                          indicatorWeight: 5,
                          indicatorColor: Colors.green,
                          tabs: [
                            Tab(text: 'Current', icon: Icon(Icons.pending_actions)),
                            Tab(
                                text: 'Sheduled',
                                icon: Icon(Icons.punch_clock_rounded)),
                            Tab(text: 'Completed', icon: Icon(Icons.done)),
                          ],
                        ),
                        title: Text('My Caterers'),
                      ),
                      body: TabBarView(
                        children: [
                          PendingOrders(),
                          Icon(Icons.directions_transit, size: 350),
                          Icon(Icons.directions_car, size: 350),
                        ],
                      ),
                    ),
                  );
                });


      }
    );
  }
}

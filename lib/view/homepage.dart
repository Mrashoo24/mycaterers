import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mycaterers/utils/common/responsive.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/view/pendingOrders.dart';

import '../utils/common/colors.dart';
import '../utils/common/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DateTime? pickedDate;
  int selectedRadio = 1;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                        return StatefulBuilder(builder: (context, dialogState) {
                          return AlertDialog(
                            content: Container(
                              height: ResponsiveDimensions.getHeigth(context)
                                      .height *
                                  0.5,
                              width:
                                  ResponsiveDimensions.getHeigth(context).width,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'No. of Person',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: korangeAccent)),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: korangeAccent)),
                                    ),
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                    ],
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: RadioListTile(
                                          title: Text('Normal'),
                                          value: 1,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.green,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedRadio = val!;
                                            });
                                            dialogState(() {});
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile(
                                          title: Text('Buffet'),
                                          value: 2,
                                          groupValue: selectedRadio,
                                          activeColor: Colors.blue,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedRadio = val!;
                                            });
                                            dialogState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          DatePicker.showDateTimePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now().add(Duration(hours: 6)),
                                              maxTime: DateTime.now().add(Duration(days: 360)), onChanged: (date) {

                                              }, onConfirm: (date) {
                                                print('confirm $date');
                                                setState(() {
                                                  pickedDate = date;
                                                });
                                                dialogState(() {
                                                });
                                              }, currentTime: DateTime.now(),);
                                        },
                                        child: Text(
                                          pickedDate == null ? 'Select Date' : pickedDate!.toLocal().toString(),
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                    Icon(Icons.calendar_month)
                                  ],
                                ),

                                  SizedBox(height: 20,),

                                  Utils.circularTextField(
                                      controller: addressController,
                                      maxLine: 5,
                                      onChange: (value) {},
                                      hint:
                                      'Enter event address',
                                      label: 'Event Address',
                                      obsecure: false,
                                      validator: (value) {}),

                                 SizedBox(height: 20,),

                                  Utils.circularTextField(
                                      controller: notesController,
                                      maxLine: 5,
                                      onChange: (value) {},
                                      hint:
                                          'Enter event type and other details',
                                      label: 'Notes',
                                      obsecure: false,
                                      validator: (value) {}),
                                  SizedBox(height: 40,),
                                  Utils.buttonGreen('Proceed', () {
                                    Navigator.of(context)
                                        .pushNamed(RouteNames.foodListScreen);
                                  })
                                ],
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
              Tab(text: 'Completed', icon: Icon(Icons.done)),
              Tab(text: 'Cancelled', icon: Icon(Icons.cancel)),
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
  }
}

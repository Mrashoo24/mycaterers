// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mycaterers/controllers/ordersController.dart';
// import 'package:mycaterers/data/model/CategoryMode.dart';
// import 'package:mycaterers/data/model/foodModel.dart';
// import 'package:mycaterers/data/model/typemodel.dart';
// import 'package:mycaterers/utils/common/colors.dart';
// import 'package:collection/collection.dart';
// import 'package:mycaterers/utils/common/utils.dart';
// import 'package:mycaterers/utils/routes/routenames.dart';
// import 'package:mycaterers/utils/routes/routes.dart';
//
// class FoodSelectScreen extends StatefulWidget {
//   const FoodSelectScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FoodSelectScreen> createState() => _FoodSelectScreenState();
// }
//
// class _FoodSelectScreenState extends State<FoodSelectScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return GetBuilder(
//       init: Get.put(OrderController()),
//       builder: (ordercontroller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Select Foods'),
//             actions: [
//               if( ordercontroller.selectedCatList.isNotEmpty)  InkWell(
//                 onTap: () {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//
//
//                         return StatefulBuilder(
//                           builder: (context1,dialogState) {
//
//                             return AlertDialog(
//                               actions: [
//                                 ElevatedButton(onPressed: (){
//                                   Get.offAllNamed(RouteNames.home);
//                                 }, child: Text('SEND'))
//                               ],
//                               content: Container(
//                                 height: 300,
//                                 width: 200,
//                                 child: ListView.builder(
//                                     itemCount: ordercontroller.selectedCatList.length,
//                                     itemBuilder: (context, index) {
//                                       var currentCat = ordercontroller.selectedCatList[index];
//
//                                       return ExpansionTile(
//                                           iconColor: kgreen,
//                                           key: GlobalKey(),
//                                           initiallyExpanded: ordercontroller.openedIndex == index,
//                                           onExpansionChanged: (opened) {
//
//                                               ordercontroller.changeOpenIndex(index) ;
//
//                                           },
//                                           title: Text(
//                                             currentCat.name!,
//                                             style: TextStyle(color: korangeColor),
//                                           ),
//                                           children: currentCat.selectedFoods!
//                                               .mapIndexed((index, element) {
//                                             FoodModel? currentFoodinList = currentCat
//                                                 .selectedFoods!
//                                                 .firstWhereOrNull(
//                                                     (e) => e.id == element.id);
//
//                                             return InkWell(
//                                               onTap: () {
//
//                                                   ordercontroller.selectedCatList[index]
//                                                   .selectedFoods!
//                                                       .remove(element);
//
//                                                   ordercontroller.update();
//
//                                                 // dialogState(() {
//                                                 //   currentCat.selectedFoods!
//                                                 //       .remove(element);
//                                                 // });
//
//                                               },
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: 20.0, vertical: 10),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.spaceBetween,
//                                                   children: [
//                                                     Text(element.name!),
//                                                     currentFoodinList == null
//                                                         ? Icon(
//                                                             Icons.check_box_outline_blank)
//                                                         : Icon(
//                                                             Icons.check_box,
//                                                             color: kgreen,
//                                                           )
//                                                   ],
//                                                 ),
//                                               ),
//                                             );
//                                           }).toList());
//                                     }),
//                               ),
//                             );
//                           }
//                         );
//                       });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: kgreen,
//                     ),
//                     child: Row(
//                       children: [
//                         Text('View Cart'),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Icon(Icons.remove_red_eye_outlined)
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           // floatingActionButton: FloatingActionButton(onPressed: () {
//           //   setState(() {
//           //     _scrollController.animateTo(2 * 60.0,
//           //         duration: Duration(milliseconds: 500), curve: Curves.ease);
//           //   });
//           // },
//           //   child: Icon(Icons.add),
//           //
//           // ),
//           body: Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     InkWell(
//                       onTap: (){
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return StatefulBuilder(
//                                   builder: (context,dialogState) {
//
//                                     return AlertDialog(
//                                       content: Container(
//                                         height: 300,
//                                         width: 200,
//                                         child: ListView.builder(
//                                             itemCount: ordercontroller.typeList.length,
//                                             itemBuilder: (context, index) {
//
//                                              var currentTypeList = ordercontroller.selectedType.contains(ordercontroller.typeList[index].id);
//
//                                                     return InkWell(
//                                                       onTap: () {
//                                                     ordercontroller.changeCurrentFoodlist(currentTypeList, index);
//
//
//
//                                                       },
//                                                       child: Padding(
//                                                         padding: const EdgeInsets.symmetric(
//                                                             horizontal: 20.0, vertical: 10),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment.spaceBetween,
//                                                           children: [
//                                                             Text(ordercontroller.typeList[index].name!),
//                                                             !currentTypeList
//                                                                 ? Icon(
//                                                                 Icons.check_box_outline_blank)
//                                                                 : Icon(
//                                                               Icons.check_box,
//                                                               color: kgreen,
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     );
//
//                                             }),
//                                       ),
//                                       actions: [
//                                         Utils.buttonGreen('OK',
//                                          (){
//                                           Navigator.of(context).pop();
//                                         })
//                                       ],
//                                     );
//                                   }
//                               );
//                             });
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 10,vertical: 50),
//                         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                         decoration: BoxDecoration(border: Border.all(color: Colors.black)),
//                         child: Row(
//
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text('Filter',style: TextStyle(fontWeight: FontWeight.bold),),
//                             Icon(Icons.filter_alt_outlined)
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 20,),
//                    if (ordercontroller.selectedType.isNotEmpty)  InkWell(
//                        onTap: (){
//                          ordercontroller.selectedType.clear();
//                          ordercontroller.update();
//
//                        },
//                        child: Text('CLEAR FILTER')),
//                     if (ordercontroller.selectedType.isNotEmpty)  InkWell(
//                         onTap: (){
//                           ordercontroller.selectedType.clear();
//                           ordercontroller.update();
//
//                         },
//                         child: Icon(Icons.close)),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Builder(
//                   builder: (context) {
//
//                     print('selectedType = ${ordercontroller.selectedType}');
//
//                     return ListView.builder(
//                         controller: ordercontroller.scrollController,
//                         itemCount: ordercontroller.filteredCatList!.length,
//                         itemBuilder: (context, index) {
//                           var currentCat = ordercontroller.filteredCatList![index];
//
//                           return ExpansionTile(
//                               iconColor: kgreen,
//                               key: GlobalKey(),
//                               initiallyExpanded: ordercontroller.openedIndex == index,
//                               onExpansionChanged: (opened) {
//
//                                 setState(() {
//                                   ordercontroller.openedIndex == index ? ordercontroller.changeOpenIndex(-1) : ordercontroller.changeOpenIndex(index);
//                                 });
//                               },
//                               title: Text(
//                                 currentCat.name!,
//                                 style: TextStyle(color: korangeColor),
//                               ),
//                               children: currentCat.listOfFoods!.mapIndexed((index, element) {
//
//                                 FoodModel? currentFoodinList = currentCat.selectedFoods!
//                                     .firstWhereOrNull((e) => e.id == element.id);
//
//                                 return InkWell(
//                                   onTap: () {
//                                     if( ordercontroller.selectedCatList.isNotEmpty) {
//                                       print(
//                                           'selectedCatList = ${ordercontroller.selectedCatList.first.id}');
//                                       print(
//                                           'selectedCatList = ${ordercontroller.selectedCatList.last.id}');
//                                     }
//
//                                     if (currentFoodinList == null) {
//                                       ordercontroller.filteredCatList![index].selectedFoods!.add(element);
//                                        ordercontroller.update();
//                                       // // currentCat.selectedFoods!.add(element);
//                                       //
//                                       //  var addedList = ordercontroller.catList![index].selectedFoods!;
//
//
//                                      ordercontroller.updateListOfCat();
//                                      setState(() {
//
//                                      });
//
//                                     } else {
//                                       ordercontroller.filteredCatList![index].selectedFoods!.remove(element);
//                                       ordercontroller.update();
//
//                                       // var addedList = catList[index].selectedFoods!;
//                                       // ordercontroller.update();
//                                       ordercontroller.updateListOfCat();
//
//                                       setState(() {
//                                         // listoFSelectedFoods.add(catList[index].copyWith(selectedFoods: addedList));
//                                       });
//                                     }
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 20.0, vertical: 10),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(element.name!),
//                                         currentFoodinList == null
//                                             ? Icon(Icons.check_box_outline_blank)
//                                             : Icon(
//                                                 Icons.check_box,
//                                                 color: kgreen,
//                                               )
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }).toList());
//                         });
//                   }
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mycaterers/controllers/ordersController.dart';
import 'package:mycaterers/data/model/CategoryMode.dart';
import 'package:mycaterers/data/model/foodModel.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/utils/common/colors.dart';
import 'package:collection/collection.dart';
import 'package:mycaterers/utils/routes/routenames.dart';
import 'package:mycaterers/utils/routes/routes.dart';

import '../data/model/typemodel.dart';
import '../utils/common/commonfunctions.dart';
import '../utils/common/utils.dart';

class FoodSelectScreen extends StatefulWidget {
  const FoodSelectScreen({Key? key}) : super(key: key);

  @override
  State<FoodSelectScreen> createState() => _FoodSelectScreenState();
}

class _FoodSelectScreenState extends State<FoodSelectScreen> {
  var openedIndex = -1;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<_FoodSelectScreenState> expansionTile = new GlobalKey();

  List<CategoryModel> listoFSelectedFoods = [];

  List<CategoryModel>? catList;

  var typeList = [
  ];

  List<String> selectedType = [];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        init: Get.put<OrderController>(OrderController()),
        builder: (orderController) {
          typeList = orderController.typeList!;

          catList = orderController.catList!;

          return orderController.typeList == null ||  orderController.catList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Builder(builder: (context) {
                  print('check=${orderController.listoFSelectedFoods}');
                  var selectedCatList = orderController.listoFSelectedFoods
                      .map((e) => catList!.firstWhereOrNull(
                          (element) => e.catid!.contains(element.id)))
                      .toList();

                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Select Foods'),
                      actions: [
                        if (selectedCatList.isNotEmpty)
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GetBuilder<OrderController>(
                                        builder: (diOrderController) {
                                      return AlertDialog(
                                        actions: [
                                          Utils.circularOrangeButton(
                                              onPressed: () {
                                                CommonFunctions()
                                                    .insertFirebaseDoc(
                                                        collectionName:
                                                            'enquiry',
                                                        data: OrderModel(
                                                          uid: FirebaseAuth.instance.currentUser?.uid,
                                                          id: '',
                                                          datetime: DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now()),
                                                          eventDate:  DateFormat('yyyy-MM-dd hh:mm a').format(orderController.pickedDate!),
                                                          area: orderController.addressController.text,

                                                          pincode: orderController.pincodeController.text,
                                                          notes: orderController.notesController.text,
                                                          listoffoods: orderController.listoFSelectedFoods,
                                                          type: orderController.selectedRadio.toString() ,
                                                          personCount: orderController.countController.text.toString(),status: 'Pending'

                                                        ).toJson(),
                                                        successMessage:
                                                            'Quotation sent').then((value) async {

                                                            var result = await  CommonFunctions().updateFirebaseDoc(collectionName: 'enquiry', data: {'id':value!.id}, successMessage: 'Quotation sent', docid: value.id);

                                                          if(result != null){


                                                            Utils.showSuccesstoast('Quotation sent');

                                                            Get.offAllNamed(RouteNames.home);

                                                          }else{

                                                            Utils.showErrorToast('Something went wrong');


                                                          }
                                                            });
                                              },
                                              label: 'Send')
                                        ],
                                        content: Container(
                                          height: 300,
                                          width: 200,
                                          child: ListView.builder(
                                              itemCount: selectedCatList.length,
                                              itemBuilder: (context, index) {
                                                var currentCat =
                                                    selectedCatList[index];
                                                print(
                                                    'check cat  = ${openedIndex}');

                                                return ExpansionTile(
                                                    iconColor: kgreen,
                                                    key: GlobalKey(),
                                                    initiallyExpanded:
                                                        openedIndex == index,
                                                    onExpansionChanged:
                                                        (opened) {
                                                      setState(() {
                                                        openedIndex == index
                                                            ? openedIndex = -1
                                                            : openedIndex =
                                                                index;
                                                      });
                                                    },
                                                    title: Text(
                                                      currentCat!.name!,
                                                      style: TextStyle(
                                                          color: korangeColor),
                                                    ),
                                                    children: orderController
                                                        .listoFSelectedFoods
                                                        .mapIndexed(
                                                            (index, element) {
                                                      FoodModel?
                                                          currentFoodinList =
                                                          orderController
                                                              .listoFSelectedFoods
                                                              .firstWhereOrNull((e) => e
                                                                  .catid!
                                                                  .contains(
                                                                      currentCat
                                                                          .id));

                                                      return InkWell(
                                                        onTap: () {
                                                          orderController
                                                              .listoFSelectedFoods
                                                              .remove(element);
                                                          orderController
                                                              .update();

                                                          if (orderController
                                                              .listoFSelectedFoods
                                                              .isEmpty) {
                                                            Get.back();
                                                          }
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      20.0,
                                                                  vertical: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(element
                                                                  .name!),
                                                              currentFoodinList ==
                                                                      null
                                                                  ? Icon(Icons
                                                                      .check_box_outline_blank)
                                                                  : Icon(
                                                                      Icons
                                                                          .check_box,
                                                                      color:
                                                                          kgreen,
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }).toList());
                                              }),
                                        ),
                                      );
                                    });
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kgreen,
                                ),
                                child: Row(
                                  children: [
                                    Text('View Cart'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Icon(Icons.remove_red_eye_outlined)
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    // floatingActionButton: FloatingActionButton(onPressed: () {
                    //   setState(() {
                    //     _scrollController.animateTo(2 * 60.0,
                    //         duration: Duration(milliseconds: 500),
                    //         curve: Curves.ease);
                    //   });
                    // }),
                    body: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, dialogState) {
                                          return AlertDialog(
                                            content: Container(
                                              height: 300,
                                              width: 200,
                                              child: ListView.builder(
                                                  itemCount: typeList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var currentTypeList =
                                                        selectedType.contains(
                                                            typeList[index].id);

                                                    return InkWell(
                                                      onTap: () {
                                                        // ordercontroller.changeCurrentFoodlist(currentTypeList, index);
                                                        currentTypeList
                                                            ? selectedType
                                                                .remove(typeList[
                                                                        index]
                                                                    .id)
                                                            : selectedType.add(
                                                                typeList[index]
                                                                    .id!);
                                                        setState(() {});

                                                        dialogState(() {});
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    20.0,
                                                                vertical: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(typeList[index]
                                                                .name!),
                                                            !currentTypeList
                                                                ? Icon(Icons
                                                                    .check_box_outline_blank)
                                                                : Icon(
                                                                    Icons
                                                                        .check_box,
                                                                    color:
                                                                        kgreen,
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            actions: [
                                              Utils.buttonGreen('OK', () {
                                                Navigator.of(context).pop();
                                              })
                                            ],
                                          );
                                        });
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 50),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Filter',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.filter_alt_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              if (selectedType.isNotEmpty)
                                InkWell(
                                    onTap: () {
                                      selectedType.clear();
                                      // ordercontroller.update();
                                      setState(() {});
                                    },
                                    child: Text('CLEAR FILTER')),
                              if (selectedType.isNotEmpty)
                                InkWell(
                                    onTap: () {
                                      selectedType.clear();
                                      // ordercontroller.update();
                                      setState(() {});
                                    },
                                    child: Icon(Icons.close)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Builder(builder: (context) {
                            var filteredCatList = selectedType.isEmpty
                                ? catList
                                : catList!
                                    .where((element) => element.type!
                                        .toSet()
                                        .containsAll(selectedType))
                                    .toList();

                            return ListView.builder(
                                controller: _scrollController,
                                itemCount: filteredCatList!.length,
                                itemBuilder: (context, index) {
                                  var currentCat = filteredCatList[index];

                                  return StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection('foods')
                                          .where('catid',
                                              arrayContains: currentCat.id)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        List<FoodModel> foodModel = snapshot
                                            .requireData.docs
                                            .map((e) =>
                                                FoodModel.fromJson(e.data()))
                                            .toList();

                                        return ExpansionTile(
                                            iconColor: kgreen,
                                            key: GlobalKey(),
                                            initiallyExpanded:
                                                openedIndex == index,
                                            onExpansionChanged: (opened) {
                                              setState(() {
                                                openedIndex =
                                                    openedIndex == index
                                                        ? -1
                                                        : index;
                                              });
                                            },
                                            title: Text(
                                              currentCat.name!,
                                              style: TextStyle(
                                                  color: korangeColor),
                                            ),
                                            children: foodModel
                                                .mapIndexed((index, element) {
                                              FoodModel? currentFoodinList =
                                                  orderController
                                                      .listoFSelectedFoods
                                                      .firstWhereOrNull((e) =>
                                                          e.id == element.id);

                                              return InkWell(
                                                onTap: () {
                                                  if (currentFoodinList ==
                                                      null) {
                                                    orderController
                                                        .listoFSelectedFoods
                                                        .add(element);
                                                    orderController.update();
                                                  } else {
                                                    orderController
                                                        .listoFSelectedFoods
                                                        .remove(element);
                                                    orderController.update();
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(element.name!),
                                                      currentFoodinList == null
                                                          ? Icon(Icons
                                                              .check_box_outline_blank)
                                                          : Icon(
                                                              Icons.check_box,
                                                              color: kgreen,
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList());
                                      });
                                });
                          }),
                        ),
                      ],
                    ),
                  );
                });
        });
  }
}

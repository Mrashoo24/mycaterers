import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:mycaterers/controllers/authcontroller.dart';
import 'package:mycaterers/data/model/ordersModel.dart';
import 'package:mycaterers/data/model/vendorEnquiryModel.dart';
import 'package:mycaterers/data/model/vendorModel.dart';
import 'package:mycaterers/utils/common/commonfunctions.dart';
import 'package:mycaterers/utils/common/utils.dart';

import '../data/model/CategoryMode.dart';
import '../data/model/foodModel.dart';
import '../data/model/typemodel.dart';

class OrderController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController countController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  
  TextEditingController amountController = TextEditingController();

  AuthController authController = Get.put(AuthController());

  DateTime? pickedDate;
  int selectedRadio = 1;

  late OrderModel _selectedOrder;


  var openedIndex = -1;
  final ScrollController scrollController = ScrollController();

  List<FoodModel> listoFSelectedFoods = [];

  List<CategoryModel>? filteredCatList ;

  List<CategoryModel>? catList;

  List<TypeModel>? typeList;

  List<String> selectedType = [];

  final ordersList = <OrderModel>[].obs;


  OrderModel get selectedOrder => _selectedOrder;


  List<CategoryModel> selectedCatList = [];

  @override
  void onInit() {
    getFilterList();
    getCatList();
print('checkui = ${authController.userModel}');
    if(authController.userModel != null ) {
      ordersList.bindStream(lista());
    }

    super.onInit();
  }

  changeSelectedOrder(OrderModel order){
    _selectedOrder = order;
    update();
  }

  Stream <List<VendorQouteModel>> listofVendorQoutes(String? orderid) {
    Stream <QuerySnapshot<Map<String,dynamic>>> stream =
    FirebaseFirestore.instance.collection('vendorQoutes').where('orderid',isEqualTo: orderid).snapshots();

    stream.listen((event) {print('checklength = ${event.docs.length}');});

    return stream.map((qShot) => qShot.docs
        .map((doc) => VendorQouteModel.fromJson(doc.data()))
        .toList());
  }

  Future<VendorModel> getVendor(String? vendorId) async {
    QuerySnapshot<Map<String,dynamic>> future =
   await  FirebaseFirestore.instance.collection('vendors').where('uid',isEqualTo: vendorId).get();

    return VendorModel.fromJson(future.docs.first.data());
  }


  Stream <List<OrderModel>> lista() {
    print('checkui = ${ authController.userModel!.uid}');
    Stream <QuerySnapshot<Map<String,dynamic>>> stream =
    FirebaseFirestore.instance.collection('enquiry').where('uid',isEqualTo: authController.userModel!.uid).snapshots();

    return stream.map(
            (qShot) {
             var doc =  qShot.docs;
             doc .sort((a,b)=> DateFormat('yyyy-MM-dd hh:mm a').parse(b.get('datetime')).compareTo(DateFormat('yyyy-MM-dd hh:mm a').parse(a.get('datetime'))));

              return
                doc
                      .map((doc) => OrderModel.fromJson(doc.data()))
                      .toList();
            }
    );
  }

  getFilterList() async {
    QuerySnapshot<Map<String, dynamic>> filteSnap =  await  FirebaseFirestore.instance.collection('filters').get();

    typeList = filteSnap.docs.map((e) => TypeModel.fromJson(e.data())).toList();


    update();

  }

  getCatList() async {
    QuerySnapshot<Map<String, dynamic>> catSnap =  await  FirebaseFirestore.instance.collection('category').get();

    catList = catSnap.docs.map((e) => CategoryModel.fromJson(e.data())).toList();
   update();


   update();

  }

  updateListOfCat(){
    selectedCatList = catList!
        .where((element) => element.selectedFoods!.isNotEmpty)
        .toList();

    print('checkEmpty = ${selectedCatList.length}');
    // filteredCatList = selectedType.isEmpty ? catList : catList!.where((element) => element.type!.toSet().containsAll(selectedType)).toList();



    update();
  }

  changeServeType(value){
    selectedRadio = value;
    update();
  }


  changeDate(value){
    pickedDate = value;
    update();
  }

  checkFormValidation(){
    if(formKey.currentState!.validate() && pickedDate != null ){
      return true;
    }else{
      return false;
    }
  }

  changeOpenIndex(value){
    openedIndex = value;
    update();
  }

  changeCurrentFoodlist(currentTypeList,index){
    currentTypeList ?    selectedType
        .remove(typeList![index].id)
        :   selectedType
        .add(typeList![index].id!)
    ;

    update();
  }

 changeQouteAmount(List<Map<String, dynamic>> listOfAmount,id){




    CommonFunctions().updateFirebaseDoc(collectionName: 'vendorQoutes', data: {
      'amount' : listOfAmount
    }, successMessage: '', docid: id);
    Get.back();
    Utils.showSuccesstoast('Request Sent');
  }


}
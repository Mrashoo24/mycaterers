import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/ordersController.dart';

import '../data/model/ordersModel.dart';
import '../utils/common/qouteCard.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: GetX<OrderController>(
        init: Get.put(OrderController()),
        builder: (orderController) {


         var pendingOrderList  =  orderController.ordersList.where((p0) => p0.status == 'Pending').toList();

          return ListView.builder(
              itemCount: pendingOrderList.length,
              itemBuilder: (context, index) {
                OrderModel orders = pendingOrderList[index];


                return buildQouteCard(orders.id!,orders.datetime!,orders.listoffoods,orderController,orders,context);
              });
        }
      ),
    );
  }

}

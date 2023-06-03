import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mycaterers/controllers/ordersController.dart';

import '../data/model/ordersModel.dart';
import '../utils/common/qouteCard.dart';

class ScheduledOrders extends StatefulWidget {
  const ScheduledOrders({Key? key}) : super(key: key);

  @override
  State<ScheduledOrders> createState() => _ScheduledOrdersState();
}

class _ScheduledOrdersState extends State<ScheduledOrders> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: GetX<OrderController>(
          init: Get.put(OrderController()),
          builder: (orderController) {


            var pendingOrderList  =  orderController.ordersList.where((p0) => p0.status == 'Scheduled').toList();

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

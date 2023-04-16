import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return buildQouteCard('22134','02','22-03-2023',context);
          }),
    );
  }

}

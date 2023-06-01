class VendorQouteModel {
  String? orderid;
  String? vendorid;
  List<Map<String,dynamic>>? amount;
  String? id;

  VendorQouteModel({
    this.id,
    this.orderid,this.vendorid,
    this.amount,
  });

  factory VendorQouteModel.fromJson(Map<String, dynamic> data) {

    List<Map<String, dynamic>> amountList = (data['amount'] as List<dynamic>)
        .map((e) => {'approved':e['approved'],'amount':e['amount']})
        .toList();


    return VendorQouteModel(
        id: data['id'],
        orderid: data['orderid'],
        vendorid: data['vendorid'],

        amount: amountList
    );
  }

  toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['orderid'] = this.orderid;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['vendorid'] = this.vendorid;

    return data;
  }
}

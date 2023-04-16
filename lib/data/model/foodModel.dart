class FoodModel {
  String? name;
  String? catid;
  String? id;



  FoodModel({this.id, this.name, this.catid,});


  factory FoodModel.fromJson(Map<String,dynamic> data){
    return FoodModel(id:data['id'],name: data['name'],
        catid: data['catid']
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['id'] = this.id;
    data['catid'] = this.catid;


    return data;
  }
}
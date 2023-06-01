import 'foodModel.dart';

class CategoryModel {
  String? name;
  List<dynamic>? type;
  int? index;
  String? id;
  List<FoodModel>? listOfFoods;
  List<FoodModel>? selectedFoods = [];


  CategoryModel({this.id, this.name, this.index,this.listOfFoods,this.selectedFoods,this.type});


  factory CategoryModel.fromJson(Map<String,dynamic> data){
    return CategoryModel(id:data['id'],name: data['name'],
        index: data['index'],listOfFoods: data['listOfFoods'],type: data['type'],selectedFoods:  data['selectedFoods'] ?? []
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['id'] = this.id;
    data['index'] = this.index;
    data['listOfFoods'] = this.listOfFoods;
    data['type'] = this.type;


    return data;
  }

  CategoryModel copyWith({
    String? name,
    int? index,
    String? id,
    List<FoodModel>? listOfFoods,List<FoodModel>? selectedFoods,List<String>? type
  }) {
    return CategoryModel(
     name: name ?? this.name,
      index: index ?? this.index,
      id: id ?? this.id,
      listOfFoods: listOfFoods ?? this.listOfFoods,
        selectedFoods : selectedFoods ?? this.selectedFoods,
      type: type ?? this.type
    );
  }


}
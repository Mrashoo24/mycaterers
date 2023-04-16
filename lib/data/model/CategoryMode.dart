import 'foodModel.dart';

class CategoryModel {
  String? name;
  int? index;
  String? id;
  List<FoodModel>? listOfFoods;
  List<FoodModel>? selectedFoods = [];


  CategoryModel({this.id, this.name, this.index,this.listOfFoods,this.selectedFoods});


  factory CategoryModel.fromJson(Map<String,dynamic> data){
    return CategoryModel(id:data['id'],name: data['name'],
        index: data['index'],listOfFoods: data['listOfFoods']
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['id'] = this.id;
    data['index'] = this.index;
    data['listOfFoods'] = this.listOfFoods;


    return data;
  }

  CategoryModel copyWith({
    String? name,
    int? index,
    String? id,
    List<FoodModel>? listOfFoods,List<FoodModel>? selectedFoods
  }) {
    return CategoryModel(
     name: name ?? this.name,
      index: index ?? this.index,
      id: id ?? this.id,
      listOfFoods: listOfFoods ?? this.listOfFoods,
        selectedFoods : selectedFoods ?? this.selectedFoods
    );
  }


}
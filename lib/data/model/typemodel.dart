import 'foodModel.dart';

class TypeModel {
  String? name;
  String? index;
  String? id;


  TypeModel({this.id, this.name, this.index});


  factory TypeModel.fromJson(Map<String,dynamic> data){
    return TypeModel(id:data['id'],name: data['name'],
        index: data['index']
    );
  }

  toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['name'] = this.name;
    data['id'] = this.id;
    data['index'] = this.index;


    return data;
  }

  TypeModel copyWith({
    String? name,
    String? index,
    String? id,
  }) {
    return TypeModel(
        name: name ?? this.name,
        index: index ?? this.index,
        id: id ?? this.id,
    );
  }


}
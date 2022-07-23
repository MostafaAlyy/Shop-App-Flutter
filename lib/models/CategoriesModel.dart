import 'package:shop_app/models/HomeModel.dart';

class CategoriesModel {
  bool? status;
  CategorieDatasModel? data;
  CategoriesModel.fromjson(Map<String, dynamic> Json) {
    status = Json['status'];
    data = CategorieDatasModel(Json['data']);
  }
}

class CategorieDatasModel {
  int? current_page;
  List<DataModel> data = [];
  CategorieDatasModel(Map<String, dynamic> Json) {
    Json['data'].forEach((element) {
      data.add(DataModel(element));
    });
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;
  DataModel(Map<String, dynamic> Json) {
    id = Json['id'];
    name = Json['name'];
    image = Json['image'];
  }
}

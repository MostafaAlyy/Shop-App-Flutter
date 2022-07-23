import 'dart:math';

class HomeModel {
  bool? status;
  HomeDataModel? data;
  HomeModel.fromjson(Map<String, dynamic> Json) {
    status = Json['status'];
    data = HomeDataModel.fromjson(Json['data']);
  }
}

class HomeDataModel {
  List<HomeBanners> banners = [];
  List<HomeProducts> products = [];
 
  HomeDataModel.fromjson(Map<String, dynamic> Json) {
    Json['banners'].forEach((element) {
      banners.add(HomeBanners(element));
    });
    Json['products'].forEach((element) {
      products.add(HomeProducts(element));
    });
  }
}

class HomeBanners {
  int? id;
  String? image;
  dynamic category;
  dynamic product;
  HomeBanners(Map<String, dynamic> Json) {
    id = Json['id'];
    image = Json['image'];
    category = Json['category'];
    product = Json['product'];
  }
}

class HomeProducts {
 late int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
 late bool in_favorites;
  bool? in_cart;

  HomeProducts(Map<String, dynamic> Json) {
    id = Json['id'];
    price = Json['price'];
    old_price = Json['old_price'];
    discount = Json['discount'];
    image = Json['image'];
    name = Json['name'];
    in_favorites = Json['in_favorites'];
    in_cart = Json['in_cart'];
    description = Json['description'];
  }
}

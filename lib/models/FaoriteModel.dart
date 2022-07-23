class ChangeFavoriteModel {
  bool? status;
  String? message;
  ChangeFavoriteModel.fromjson(Map<String, dynamic> Json) {
    status = Json['status'];
    message = Json['message'];
  }
}

class FavoritsModel {
  bool? status;
  String? message;
  Data? data;

  FavoritsModel({this.status, this.message, this.data});

  FavoritsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  List<Data2>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data2>[];
      json['data'].forEach((v) {
        data!.add(Data2.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Data2 {
  int? id;
  Product? product;

  Data2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  int? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}

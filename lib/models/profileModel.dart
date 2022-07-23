

class profileModel {
  bool? status;
  String? message;
  userData? data;
  profileModel.fromJson(Map<String, dynamic> Json) {
    status = Json['status'];
    message = Json['message'];
    data = Json['data'] != null ? userData.fromJson(Json['data']) : null;
  }
}

class userData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  // // // // userData(
  // // // //     {this.credit,
  // // // //     this.email,
  // // // //     this.id,
  // // // //     this.image,
  // // // //     this.name,
  // // // //     this.phone,
  // // // //     this.points,
  // // // //     this.token});
  userData.fromJson(Map<String, dynamic> Json) {
    credit = Json['credit'];
    email = Json['email'];
    id = Json['id'];
    image = Json['image'];
    name = Json['name'];
    phone = Json['phone'];
    points = Json['points'];
    token = Json['token'];
  }
}

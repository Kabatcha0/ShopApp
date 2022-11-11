class Borading {
  final String image;
  final String title;
  final String detail;
  Borading({required this.image, required this.title, required this.detail});
}

class ShopUser {
  late bool status;
  late String message;
  late DataFromUser data;
  ShopUser.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = DataFromUser.fromjson(json["data"]);
  }
}

class DataFromUser {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;
  DataFromUser.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}

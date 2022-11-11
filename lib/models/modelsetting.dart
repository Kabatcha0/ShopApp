class Profile {
  late bool status;
  late Data data;
  Profile.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Data.fromjson(json["data"]);
  }
}

class Data {
  late String name;
  late String email;
  late String phone;
  late String image;
  Data.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
  }
}

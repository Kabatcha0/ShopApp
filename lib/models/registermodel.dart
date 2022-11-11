class RegisterParse {
  late bool status;
  late Data data;
  RegisterParse.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Data.fromjson(json["data"]);
  }
}

class Data {
  late String token;
  Data.fromjson(Map<String, dynamic> json) {
    token = json["token"];
  }
}

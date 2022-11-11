class FavModel {
  late bool status;
  late String msg;
  FavModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    msg = json["message"];
  }
}

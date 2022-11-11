import 'package:flutter/cupertino.dart';

class SearchModel {
  late bool status;
  late Data data;
  SearchModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Data.fromjson(json["data"]);
  }
}

class Data {
  List<DataSearch> dataSearch = [];
  Data.fromjson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      dataSearch.add(DataSearch.fromjson(element));
    });
  }
}

class DataSearch {
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  late String image;
  late String name;
  late int id;
  DataSearch.fromjson(Map<String, dynamic> json) {
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["disount"];
    image = json["image"];
    name = json["name"];
    id = json["id"];
  }
}

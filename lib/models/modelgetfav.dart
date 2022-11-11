class GetFav {
  late bool status;
  late Data data;
  GetFav.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Data.fromjson(json["data"]);
  }
}

class Data {
  List<ListOfData> data1 = [];
  Data.fromjson(Map<String, dynamic> json) {
    json["data"].forEach((element) {
      data1.add(ListOfData.fromjson(element));
    });
  }
}

class ListOfData {
  late ProductGet product;
  ListOfData.fromjson(Map<String, dynamic> json) {
    product = ProductGet.fromjson(json["product"]);
  }
}

class ProductGet {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  ProductGet.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
  }
}

class ShopHome {
  late bool status;
  late HomeData data;
  ShopHome.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = HomeData.fromjson(json["data"]);
  }
}

class HomeData {
  List<Banners> banners = [];
  List<Products> products = [];
  HomeData.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(Banners.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(Products.fromjson(element));
    });
  }
}

class Banners {
  late int id;
  late String image;
  Banners.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class Products {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorite;
  late bool inCart;
  Products.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    inFavorite = json["in_favorites"];
    inCart = json["in_cart"];
  }
}

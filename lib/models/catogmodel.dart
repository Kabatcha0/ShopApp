class Catogries {
  late bool status;
  late CategoryData data;
  Catogries.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = CategoryData.fromjson(json["data"]);
  }
}

class CategoryData {
  late int currentPage;
  List<DataPage> dataPage = [];
  CategoryData.fromjson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      dataPage.add(DataPage.fromjson(element));
    });
  }
}

class DataPage {
  late int id;
  late String name;
  late String image;
  DataPage.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}

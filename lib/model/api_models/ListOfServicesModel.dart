// To parse this JSON data, do
//
//     final listOfServicesModel = listOfServicesModelFromJson(jsonString);

import 'dart:convert';

ListOfServicesModel listOfServicesModelFromJson(String str) => ListOfServicesModel.fromJson(json.decode(str));

String listOfServicesModelToJson(ListOfServicesModel data) => json.encode(data.toJson());

class ListOfServicesModel {
  ListOfServicesModel({
    this.status,
    this.code,
    this.data,
    this. error
  });

  bool status;
  int code;
  Data data;
  String error;
  factory ListOfServicesModel.fromJson(Map<String, dynamic> json) => ListOfServicesModel(
    status: json["status"],
    code: json["code"],
    data: json["data"] != null &&
        (json["data"] as Map<String, dynamic>).isNotEmpty
        ? Data.fromJson(json["data"])
        : null,
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
    "error": data.toJson(),
  };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.isSelected
  });

  int id;
  String name;
  String image;
  int parentId;
  bool isSelected;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    parentId: json["parent_id"],
    isSelected: json["is_selected"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "parent_id": parentId,
    "is_selected": isSelected
  };
}

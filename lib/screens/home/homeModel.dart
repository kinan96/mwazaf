// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.noAttendances,
    this.users,
  });

  int noAttendances;
  Users users;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        noAttendances: json["no_attendances"],
        users: json['users'] == null || json['users'].length == 0
            ? Users(
                items: [],
                paginate: Paginate(count: 0, total: 0, nextPageUrl: null))
            : Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "no_attendances": noAttendances,
        "users": users.toJson(),
      };
}

class Users {
  Users({
    this.items,
    this.paginate,
  });

  List<Item> items;
  Paginate paginate;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        items: json.length == 0
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        paginate: json.length == 0
            ? Paginate(count: 0, nextPageUrl: null, total: 0)
            : Paginate.fromJson(json["paginate"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "paginate": paginate.toJson(),
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.code,
    this.role,
    this.attendance,
  });

  int id;
  String name;
  String image;
  String phone;
  String code;
  String role;
  Attendance attendance;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        phone: json["phone"],
        code: json["code"],
        role: json["role"],
        attendance: Attendance.fromJson(json["attendance"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "image": image,
        "code": code,
        "role": role,
        "attendance": attendance.toJson(),
      };
}

class Attendance {
  Attendance({
    this.attendance,
    this.laate,
  });

  String attendance;
  String laate;

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        attendance: json["attendance"],
        laate: json["late"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "attendance": attendance,
        "late": laate,
      };
}

class Paginate {
  Paginate({
    this.total,
    this.count,
    this.perPage,
    this.nextPageUrl,
    this.prevPageUrl,
    this.currentPage,
    this.totalPages,
  });

  int total;
  int count;
  int perPage;
  String nextPageUrl;
  String prevPageUrl;
  int currentPage;
  int totalPages;

  factory Paginate.fromJson(Map<String, dynamic> json) => Paginate(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        nextPageUrl: json["next_page_url"],
        prevPageUrl: json["prev_page_url"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "next_page_url": nextPageUrl,
        "prev_page_url": prevPageUrl,
        "current_page": currentPage,
        "total_pages": totalPages,
      };
}

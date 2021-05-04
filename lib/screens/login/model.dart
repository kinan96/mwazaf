// To parse this JSON UserData, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({this.value, this.data, this.password});

  bool value;
  UserData data;
  String password;

  factory LoginModel.fromJson(Map<String, dynamic> json, {String password}) =>
      LoginModel(
          value: json["value"].toString() == "true",
          data: UserData.fromJson(json["data"]),
          password: password ?? json["password"]);

  Map<String, dynamic> toJson() => {
        "value": value,
        "password": password,
        "data": data.toJson(),
      };
}

class UserData {
  UserData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.userId,
    this.userCode,
    this.isActive,
    this.governorate,
    this.hasSecuritySkills,
    this.registerAt,
    this.role,
    this.gender,
    this.token,
  });

  int id;
  String name;
  String phone;
  String email;
  int userId;
  int userCode;
  int isActive;
  int governorate;
  int hasSecuritySkills;
  DateTime registerAt;
  String role;
  String gender;
  String token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: int.tryParse(json["id"].toString()),
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        userId: int.tryParse(json["userID"].toString()),
        userCode: int.tryParse(json["user_code"].toString()),
        isActive: int.tryParse(json["is_active"].toString()),
        governorate: int.tryParse(json["governorate"].toString()),
        hasSecuritySkills: int.tryParse(json["has_security_skills"].toString()),
        registerAt: DateTime.parse(json["register_at"]),
        role: json["role"],
        gender: json["gender"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "userID": userId,
        "user_code": userCode,
        "is_active": isActive,
        "governorate": governorate,
        "has_security_skills": hasSecuritySkills,
        "register_at":
            "${registerAt.year.toString().padLeft(4, '0')}-${registerAt.month.toString().padLeft(2, '0')}-${registerAt.day.toString().padLeft(2, '0')}",
        "role": role,
        "gender": gender,
        "token": token,
      };
}

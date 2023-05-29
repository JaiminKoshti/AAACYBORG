// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  List<Datum> data;
  String message;
  String status;

  Login({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };
}

class Datum {
  String token;
  String userType;

  Datum({
    required this.token,
    required this.userType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    token: json["Token"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token,
    "userType": userType,
  };
}

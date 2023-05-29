// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  List<Datum> data;
  String message;
  String status;

  Welcome({
    required this.data,
    required this.message,
    required this.status,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
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
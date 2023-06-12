import 'dart:convert';
import 'package:aaacyborg/screens/home_screen.dart';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InquiryController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String requiredViews = "10";
  String videoLink =
      "https://www.youtube.com/watch?v=EfuTdYYwSfY&ab_channel=Cric7Videos";

  Future<void> inquiry() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.inquiry);
      Map body = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailNameController.text,
        'phone': phoneController.text,
        'message': messageController.text,
        'required_views': requiredViews,
        'video_link': videoLink,
        'token': token,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.statusCode);
          print(json["status"]);
        }

        Get.offAll(const HomeScreen());
        firstNameController.clear();
        lastNameController.clear();
        emailNameController.clear();
        phoneController.clear();
        messageController.clear();
        if (json['status'] == true) {
          if (kDebugMode) {
            print(json['data']);
          }

          //var dataArray = (json['data'] as List);
          var message = json['message'];
          if (kDebugMode) {
            print('.....,,,,,,$message');
          }

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('message', message);
          /*if (dataArray.isNotEmpty) {
            var data = dataArray[0];
            print(data['first_name']);


            print(token);

            //Get.to(const HomeScreen());
            //Get.offAll(const HomeScreen());
            *//*Navigator.pop(BuildContext as BuildContext);*//*
            final userProvider =
                Provider.of<UserProvider>(Get.context!, listen: false);
            *//*userProvider.setUser(userNameController.text);
            userNameController.clear();
            passwordController.clear();*//*
          }*/
        } else {
          if (kDebugMode) {
            print(json['status']);
          }
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        if (kDebugMode) {
          print(jsonDecode(response.body)["message"]);
          print(response.statusCode);
        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Error'),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}

import 'dart:convert';
import 'package:aaacyborg/utils/apis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddCampaignController extends GetxController {



  Future<void> addCampaign() async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final enteredURL = prefs.getString('enteredURL');
    final viewQuantity = prefs.getInt('viewQuantity');
    final watchSec = prefs.getInt('watchSec');

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.addCampaign);
      Map body = {
        'video_url' : enteredURL,
        'video_quantity' : viewQuantity,
        'required_watch_seconds' : watchSec,
        'vip_account_reduce_point' : 0,
        'video_point_cost' : 20,
        'token' : token
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (kDebugMode) {
          print(response.statusCode);
          print(json["status"]);
        }

        if (json['status'] == true) {
          if (kDebugMode) {
            print(json['data']);
          }

          var dataArray = (json['data'] as List);
          if (dataArray.isNotEmpty) {
            var data = dataArray[0];
            var token = data['token'];

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('token', token);

            /*Get.to(const HomeScreen());
            userNameController.clear();
            passwordController.clear();*/
            /*final userProvider =
                Provider.of<UserProvider>(Get.context!, listen: false);
            userProvider.setUser(userNameController.text);
            userNameController.clear();
            passwordController.clear();*/
            /*forTokenController;*/
          }
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

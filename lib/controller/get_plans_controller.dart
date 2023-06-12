import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/apis.dart';

class GetPlansController extends GetxController {
  RxList<dynamic> getPlansList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPlans();
  }

  Future<void> getPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.getPlans);
      Map body = {
        'token': token,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        // getCampaign successful
        if (kDebugMode) {
          print(response.statusCode);
        }
        final json = jsonDecode(response.body);
        if (json['status'] == true) {
          if (kDebugMode) {
            print("<<<<<<<<${json['status']}>>>>>>>>>>>>>");
          }
          //print(json['data'][0]);
          if (kDebugMode) {
            print(json['message']);
          }
          getPlansList.value = (json['data'] as List ) as List<dynamic>;
          //print(token);


          if (getPlansList.value.isNotEmpty) {
            var dataSize = getPlansList.value.length;
            if (kDebugMode) {
              print("<<<<<<<${getPlansList.value.length}");
            }

            var points = getPlansList.value[0]['points'];
            if (kDebugMode) {
              print('.........$points');
            }

            var planCurrency = getPlansList.value[0]['plan_currency'];
            if (kDebugMode) {
              print('.........$planCurrency');
            }

            var planAmount = getPlansList.value[0]['plan_amount'];
            if (kDebugMode) {
              print('.........$planAmount');
            }

            var id = getPlansList.value[0]['id'];
            if (kDebugMode) {
              print('$id');
            }

            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setInt('dataSize', dataSize);
            await prefs.setInt('points', points);
            await prefs.setInt('plan_amount', planAmount);
            await prefs.setInt('id', id);
            await prefs.setString('plan_currency', planCurrency);
          }
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error";
        }
      } else {
        // Campaign get error.
        if (kDebugMode) {
          print('Campaign get error.');
        }
        throw jsonDecode(response.body)["message"] ?? "Unknown Error";
      }
    } catch (e) {
      // Error occurred during logout
      if (kDebugMode) {
        print('Error during error: $e');
      }
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

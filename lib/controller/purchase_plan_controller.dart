import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/apis.dart';

class PurchasePlanController extends GetxController {
  Future<void> purchasePlan() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final planId = prefs.getInt('id');

    try {
      if (kDebugMode) {
        print('..................$planId');
      }
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.purchasePlan);
      Map body = {
        "plan_id": planId,
        "transaction_id": '1112dsfsdfsdfswerwer01111',
        'token': token,
      };

      if (kDebugMode) {
        print('..................$planId');
      }
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
            print(json['data']);
            print(json['data']['points']);
          }
          var dataArray = (json['data']);
          var message = (json['message']);
          //print(token);

          if (dataArray.isNotEmpty) {
            print(dataArray);
            var dataSize = dataArray.length;
            if (kDebugMode) {
              print("<<<<<<<${dataArray.length}");
            }

            var newPoints = dataArray['points'];
            if (kDebugMode) {
              print('.........$newPoints');
            }

            /*var planCurrency = dataArray[0]['plan_currency'];
            if (kDebugMode) {
              print('.........$planCurrency');
            }

            var planAmount = dataArray[0]['plan_amount'];
            if (kDebugMode) {
              print('.........$planAmount');
            }*/

            /*var id = dataArray[0]['id'];
            if (kDebugMode) {
              print('.........$id');
            }*/

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('dataSize', dataSize);
            await prefs.setString('newPoints', newPoints);
            Get.back();
            Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            /*await prefs.setInt('plan_amount', planAmount);
            await prefs.setString('plan_currency', planCurrency);*/
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
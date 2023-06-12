import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/apis.dart';

class SendVipRequestController extends GetxController{
  Future<void> sendVipRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.sendRequestVIP);
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
          if (kDebugMode) {
            print(json['message']);
          }
          //var dataArray = (json['data'] as List );
          //print(token);

          var message = json['message'];
          if (kDebugMode) {
            print('.........$message');
          }

          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Get.back();

          /*if(dataArray.isNotEmpty){

            if (kDebugMode) {
              print("<<<<<<<${dataArray}");
            }

            var message = json['message'];
            if (kDebugMode) {
              print('.........$message');
            }

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('messageForVIP', message);


          }*/
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
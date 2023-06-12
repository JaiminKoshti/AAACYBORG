import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utils/apis.dart';

class GetCampaignController extends GetxController {
  RxList<dynamic> dataList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCampaign();
  }

  Future<void> getCampaign() async {
    /*final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');*/

    var token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL2xvZ2luIiwiaWF0IjoxNjg1NjgxNjAzLCJuYmYiOjE2ODU2ODE2MDMsImp0aSI6IkttemYyWnQzRDBJUzFyOHoiLCJzdWIiOiIyMyIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.kafJCURm5F2prBc3cexabkYJSW6H14SKA2XtG4Uk7TM";

    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.getCampaign);
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
          dataList.value = (json['data'] as List) as List<dynamic>;
          print('...ok...${dataList}');
          //print(token);

          if (dataList.value.isNotEmpty) {
            var dataSize = dataList.value.length;
            if (kDebugMode) {
              print("<<<<<<<${dataList.value.length}");
            }
            var viewedByUser = dataList.value[0]['viewed_by_user'];
            if (kDebugMode) {
              print('.........$viewedByUser');
            }
            var requiredWatchSeconds =
                dataList.value[0]['required_watch_seconds'];
            if (kDebugMode) {
              print('.........$requiredWatchSeconds');
            }
            var completedWatchDate = dataList.value[0]['completed_watch_date'];
            if (kDebugMode) {
              print('.........$completedWatchDate');
            }

            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setInt('dataSize', dataSize);
            await prefs.setInt('viewed_by_user', viewedByUser);
            await prefs.setInt('required_watch_seconds', requiredWatchSeconds);
            await prefs.setString('completed_watch_date', completedWatchDate);
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

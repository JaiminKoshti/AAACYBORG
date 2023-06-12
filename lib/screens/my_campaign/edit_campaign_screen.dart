import 'package:aaacyborg/controller/add_campaign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

class EditCampaignScreen extends StatefulWidget {
  final String url;

  const EditCampaignScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<EditCampaignScreen> createState() => _EditCampaignScreenState();
}

class _EditCampaignScreenState extends State<EditCampaignScreen> {
  final AddCampaignController addCampaignController =
      Get.put(AddCampaignController());

  //int selectedNumber = 0;
  int viewQuantity = 0;
  int watchSec = 0;
  int _total = 0;

  /*int total = (viewQuantity.toString() * watchSec) as int;*/

  Future<void> _saveValueToSharedPreferences(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int total = viewQuantity * watchSec;
    _total = total;
    await prefs.setInt('viewQuantity', viewQuantity);
    await prefs.setInt('watchSec', watchSec);
    await prefs.setInt('total', total);
  }

  /*final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///video
            SizedBox(
              height: 200,
              width: double.infinity,
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text("Video Settings",
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
            ),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),

            ///View Quantity
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('View Quantity'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select a Number'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return NumberPicker(
                                      value: viewQuantity,
                                      minValue: 0,
                                      maxValue: 5000,
                                      step: 50,
                                      haptics: true,
                                      onChanged: (value) {
                                        setState(() {
                                          viewQuantity = value;
                                        });
                                        _saveValueToSharedPreferences(
                                            viewQuantity);
                                      });
                                }),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          viewQuantity;
                                        });
                                        Get.back();
                                      },
                                      child: const Text('ok'))
                                ],
                              );
                            });
                      },
                      child: Text(viewQuantity.toString())),
                ),
              ],
            ),

            ///Watch Seconds
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Watch Seconds'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Select a Number'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return NumberPicker(
                                    value: watchSec,
                                    minValue: 0,
                                    maxValue: 900,
                                    step: 30,
                                    haptics: true,
                                    onChanged: (value) {
                                      setState(() {
                                        watchSec = value;
                                      });
                                      _saveValueToSharedPreferences(
                                          watchSec);
                                    }
                                  );
                                }),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          watchSec;
                                        });
                                        Get.back();
                                      },
                                      child: Text('ok'))
                                ],
                              );
                            });
                      },
                      child: Text(watchSec.toString())),
                ),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 2),

            ///Vip account
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('VIP account (reduce 10%)'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child:
                      ElevatedButton(onPressed: () {}, child: const Text("0")),
                ),
              ],
            ),

            ///Watch Seconds
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Total cost :'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(onPressed: () {}, child: Text('$_total')),
                ),
              ],
            ),
            const Divider(thickness: 2, color: Colors.grey),

            ///Btn Done
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      addCampaignController.addCampaign();
                    },
                    child: const Text("Done")),
              ),
            )
          ],
        ),
      ),
    );
  }
}

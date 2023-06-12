import 'package:aaacyborg/controller/get_plans_controller.dart';
import 'package:aaacyborg/controller/profile_controller.dart';
import 'package:aaacyborg/controller/purchase_plan_controller.dart';
import 'package:aaacyborg/controller/send_request_vip_controller.dart';
import 'package:aaacyborg/screens/buy_point/buy_point_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/widgets.dart';

class BuyPointScreen extends StatefulWidget {
  const BuyPointScreen({Key? key}) : super(key: key);

  @override
  State<BuyPointScreen> createState() => _BuyPointScreenState();
}

class _BuyPointScreenState extends State<BuyPointScreen> {

  final PurchasePlanController purchasePlanController = Get.put(PurchasePlanController());
  final ProfileController profileController = Get.put(ProfileController());
  final SendVipRequestController sendVipRequestController = Get.put(SendVipRequestController());

  dynamic _points = 1;
  dynamic _pointProfile = '';
  String _messageForVIP = '10';
  dynamic _pointFromPlans = 1;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ///Data From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic point = prefs.getInt('point');
    dynamic pointProfile = prefs.getInt('pointProfile');
    String? messageForVIP = prefs.getString('messageForVIP');
    dynamic pointFromPlans = prefs.getInt('point');

    setState(() {
      _pointFromPlans = pointFromPlans ?? 10;
      _points = point ?? 0;
      _pointProfile = pointProfile ?? '';
      _messageForVIP = messageForVIP ?? '10';
    });
  }

  @override
  Widget build(BuildContext context) {

    //final updatedPoints = _newPoints >= _points ? _newPoints : _points;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Text(
            "AAACYBORG",
          ),
        ),
        //leading: const Icon(Icons.ac_unit, size: 30, color: Colors.white70),
        actions: [
          Center(child: Text('$_pointProfile', textAlign: TextAlign.center)),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Image(image: AssetImage(CustomImages.diamond), width: 30),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 58),

            ///text
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 5),
              child: SizedBox(
                height: 69,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(13)),
                  child: const Padding(
                    padding: EdgeInsets.all(11.0),
                    child: Text(
                      "have purchased diamonds , please contact us if an error occurs , thank you |2jiuggl@gmail.com",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),

            ///dialog and card
            InkWell(
                child: const SizedBox(height: 500,child: BuyPointCard()),
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Buy point'),
                      content: const Text('are you sure you want but points'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'No'),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            purchasePlanController.purchasePlan();
                            Get.back();
                            //profileController.profile();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                }),

            ///btn
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    sendVipRequestController.sendVipRequest();
                  }, child: const Text('VIP Pass')),
            )
          ],
        ),
      ),
    );
  }
}

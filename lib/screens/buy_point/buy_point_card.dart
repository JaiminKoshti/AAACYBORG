import 'package:aaacyborg/controller/get_plans_controller.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyPointCard extends StatefulWidget {
  const BuyPointCard({Key? key}) : super(key: key);

  @override
  State<BuyPointCard> createState() => _BuyPointCardState();
}

class _BuyPointCardState extends State<BuyPointCard> {
  final GetPlansController getPlansController = Get.put(GetPlansController());

  dynamic _planCurrency = "Rs";
  dynamic _points = 0;
  dynamic _planMount = 10;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ///Data From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic points = prefs.getInt("points");
    dynamic planAmount = prefs.getInt("plan_amount");
    String? planCurrency = prefs.getString('plan_currency');

    setState(() {
      _points = points ?? 10;
      _planMount = planAmount ?? 10;
      _planCurrency = planCurrency ?? 'opps';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: getPlansController.getPlansList.length,
        itemBuilder: (context, index) {
          final item = getPlansController.getPlansList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 2),
            child: SizedBox(
              height: 69,
              width: double.infinity,
              child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(13)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("${item['points']}"),
                      ),
                      const Image(
                          image: AssetImage(CustomImages.diamond), width: 30),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("${item['plan_amount']} ${item['plan_currency']}"),
                      ),
                    ],
                  )),
            ),
          );
        }));
  }
}

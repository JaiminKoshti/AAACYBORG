import 'package:aaacyborg/screens/my_campaign/edit_campaign_screen.dart';
import 'package:aaacyborg/screens/my_campaign/my_campaign_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/get_campaign_controller.dart';

class MyCampaignScreen extends StatefulWidget {
  const MyCampaignScreen({Key? key}) : super(key: key);

  @override
  State<MyCampaignScreen> createState() => _MyCampaignScreenState();
}

class _MyCampaignScreenState extends State<MyCampaignScreen> {
  final _formKey = GlobalKey<FormState>();
  final GetCampaignController getCampaignController = Get.put(GetCampaignController());
  final TextEditingController _urlController = TextEditingController();
  //final url = _urlController.text;
  //dynamic _viewedByUser = "";

  ///condition on URl
  void _checkURLValidity() async {
    final enteredURL = _urlController.text.trim();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('enteredURL', enteredURL);

    if (_isURLValid(enteredURL)) {
      Get.to(EditCampaignScreen(url: enteredURL));
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid URL ',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  ///URL Validation
  bool _isURLValid(String url) {
    // Regular expression pattern to match URLs
    RegExp urlRegex = RegExp(
      r'^(?:http|https):\/\/(?:(?:[A-Z0-9]+\.)+[A-Z]{2,}|(?:\d{1,3}\.){3}\d{1,3})(?::\d+)?(?:\/[^\s]*)?$',
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegex.hasMatch(url);
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }



  ///Data From Api
  Future<void> _getData() async {
    final SharedPreferences prefsSend = await SharedPreferences.getInstance();
    //await prefsSend.setString('token', token);
    SharedPreferences prefsGet = await SharedPreferences.getInstance();
    //dynamic data = prefs.getInt('dataSize');

    setState(() {
      //_data = data ?? 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Campaign"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            ///Text
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                  "Only support up to 3 takes at the same time . Please delete the tasks",
                  style: TextStyle(color: Colors.red, fontSize: 15)),
            ),
            const SizedBox(height: 20),

            ///video url + btnAdd
            Row(
              children: [
                ///Video URL
                 Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: TextFormField(
                        controller: _urlController,
                        textAlignVertical: TextAlignVertical.bottom,
                        decoration: const InputDecoration(
                            hintText: "Input Youtube video url",
                            hintStyle: TextStyle(fontSize: 18)),
                      ),
                    )),
                ///btnAdd
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _checkURLValidity();
                        },
                        child: const Text('Add'),
                      ),),
                )
              ],
            ),
            /*Text(
              _isURLValid ? 'URL is Valid' : 'URL is Invalid',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),*/
            const SizedBox(height: 10),

            ///Card
            const SizedBox(height: 500, child: MyCampaignCard())
            /*Expanded(
              child: ListView.builder(
                itemCount: _data,
                itemBuilder: (context, index) {
                  return const MyCampaignCard();
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

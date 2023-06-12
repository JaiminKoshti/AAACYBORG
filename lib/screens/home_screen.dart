import 'package:aaacyborg/controller/get_campaign_controller.dart';
import 'package:aaacyborg/controller/get_plans_controller.dart';
import 'package:aaacyborg/controller/logout_controller.dart';
import 'package:aaacyborg/controller/profile_controller.dart';
import 'package:aaacyborg/controller/watch_video_controller.dart';
import 'package:aaacyborg/screens/add_inquiry_screen.dart';
import 'package:aaacyborg/screens/auth/login/provider.dart';
import 'package:aaacyborg/screens/buy_point/buy_point_screen.dart';
import 'package:aaacyborg/screens/contact_screen.dart';
import 'package:aaacyborg/screens/my_campaign/my_campaign_screen.dart';
import 'package:aaacyborg/screens/privacy_policy_screen.dart';
import 'package:aaacyborg/screens/watch_video_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:get/get_core/src/get_main.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/privacy_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LogoutController loginController = Get.put(LogoutController());
  final GetCampaignController getCampaignController =
      Get.put(GetCampaignController());
  final PrivacyController privacyController = Get.put(PrivacyController());
  final ProfileController profileController = Get.put(ProfileController());
  final GetPlansController getPlansController = Get.put(GetPlansController());
  final WatchVideoController watchVideoController =
      Get.put(WatchVideoController());

  String _token = '';
  dynamic _email = '';
  String _vipExpiryDate = '';
  dynamic _points = '';
  String _url = '';

  ///logout
  /*void _logout(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.logout();

    // Handle the necessary logout logic for the API or Google login scenario
    // For example, if using Google sign-in, you would call googleSignIn.signOut()

    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
      return const LoginScreen();
    }), (Route route) => false);
  }*/

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /*Future<String> _getAppVersion() async {
    if (Platform.isAndroid) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } else if (Platform.isIOS) {
      final Map<String, String> environmentVars = Platform.environment;
      return environmentVars['CFBundleShortVersionString'] ?? 'Unknown';
    } else {
      return 'Unknown';
    }
  }*/

  @override
  void initState() {
    super.initState();
    profileController.profile();
    _getData();
  }

  ///Token From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? url = prefs.getString('url');
    dynamic email = prefs.getString('email');
    dynamic point = prefs.getInt('pointProfile');
    String? vipExpiryDate = prefs.getString('vip_expiry_date');

    setState(() {
      _token = token ?? '';
      _url = url ?? '';
      _email = email ?? '';
      _points = point ?? '';
      _vipExpiryDate = vipExpiryDate ?? '000';
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleAccountProvider = Provider.of<GoogleAccountProvider>(context);
    final user = googleAccountProvider.user;
    final userProvider = Provider.of<UserProvider>(context);


    ///provider for email
    //final userProvider = Provider.of<UserProvider>(context);
    //final String? emailAPI = userProvider.user;

    final email = user != null ? user.email : _email;

    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            const SizedBox(height: 30),

            ///mail
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Account:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 10),
                        child: Text(
                          email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///points
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Points:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0, bottom: 10),
                        child: Text(
                          "$_points",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ///expiration Date
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Image(
                            image: AssetImage(CustomImages.vip_card),
                            width: 35),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "VIP expiration ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Date:",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35.0, vertical: 5),
                        child: Text(
                          _vipExpiryDate,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            ///contact us + my campaign
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: <Widget>[
                  /// contact us
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Image(
                                  image: AssetImage(CustomImages.contact_us),
                                  width: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(CustomText.context_us)
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        Get.to(const ContactScreen());
                        //await Share.share("hey !");
                      },
                    ),
                  ),

                  /// my campaign
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Image(
                                    image: AssetImage(CustomImages.my_campaign),
                                    width: 28),
                              ),
                              Text(CustomText.my_campaign)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        getCampaignController.getCampaign();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyCampaignScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Earn Point  + buy point
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: <Widget>[
                  ///Earn Point
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Image(
                                    image: AssetImage(CustomImages.video_play),
                                    width: 28),
                              ),
                              Text(CustomText.earn_point)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        watchVideoController.watchVideo();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const WatchVideoScreen()));
                      },
                    ),
                  ),

                  ///buy point
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Image(
                                    image: AssetImage(CustomImages.diamond),
                                    width: 30),
                              ),
                              Text(CustomText.buy_point)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        getPlansController.getPlans();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuyPointScreen()));
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// Inquiry + privacy policy
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: <Widget>[
                  ///Inquiry
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Image(
                                    image: AssetImage(CustomImages.inquiry),
                                    width: 30),
                              ),
                              Text("Inquiry"),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddInquiryScreen()));
                      },
                    ),
                  ),

                  ///Privacy policy
                  Expanded(
                    flex: 5,
                    child: InkWell(
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 5),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Image(
                                      image: AssetImage(
                                          CustomImages.privacy_policy),
                                      width: 30),
                                ),
                              ),
                              Text(CustomText.privacy_policy)
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        privacyController.privacy();
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// logout
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: InkWell(
                child: SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "LogOut",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Alert', textAlign: TextAlign.start),
                    content: const Text(
                      'are you sure , you want to sign out?',
                      style: TextStyle(fontSize: 14),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          loginController.logout();
                          // _logout(context);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            /// version
            Center(
              child: FutureBuilder<String>(
                future: _getAppVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text('App Version: ${snapshot.data}');
                  }
                },
              ),
            ),

            ///token
             /*Text("$_token",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),*/
          ],
        ),
      )),
    );
  }
}

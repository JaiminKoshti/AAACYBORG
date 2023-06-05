import 'package:aaacyborg/controller/logout_controller.dart';
import 'package:aaacyborg/screens/auth/login/provider.dart';
import 'package:aaacyborg/screens/buy_point_screen.dart';
import 'package:aaacyborg/screens/my_campaign_screen.dart';
import 'package:aaacyborg/screens/privacy_policy_screen.dart';
import 'package:aaacyborg/screens/watch_video_screen.dart';
import 'package:aaacyborg/screens/youtube_video_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LogoutController loginController = Get.put(LogoutController());
  String Token = '';

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

  @override
  void initState() {
    super.initState();
    _getAccessToken();
  }

  ///Token From Api
  Future<void> _getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    setState(() {
      Token = token ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final googleAccountProvider = Provider.of<GoogleAccountProvider>(context);
    final user = googleAccountProvider.user;

    ///provider for email
    //final userProvider = Provider.of<UserProvider>(context);
    //final String? emailAPI = userProvider.user;

    final email = user != null ? user.email : "emailAPI";

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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Points:",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3.0, bottom: 10),
                          child: Text(
                            "786",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
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
                              "VIP expiration",
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
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35.0, vertical: 5),
                          child: Text(
                            "2020-01-01",
                            style: TextStyle(color: Colors.red, fontSize: 17),
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
                          await Share.share("hey !");
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
                                      image:
                                          AssetImage(CustomImages.my_campaign),
                                      width: 28),
                                ),
                                Text(CustomText.my_campaign)
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
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

              /// watch video + buy point
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  children: <Widget>[
                    ///watch video
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
                                      image:
                                          AssetImage(CustomImages.video_play),
                                      width: 28),
                                ),
                                Text(CustomText.watch_video)
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BuyPointScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// watch videp new + privacy policy
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Row(
                  children: <Widget>[
                    ///watch video new
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
                                      image:
                                          AssetImage(CustomImages.video_play),
                                      width: 28),
                                ),
                                Text("Watch video"),
                                Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text("new",
                                      style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebviewtubeDemo()));
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PrivacyPolicyScreen()));
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
              const Text(
                "Version : 2.0.6",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),

               ///token
              /* Text("$Token",textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

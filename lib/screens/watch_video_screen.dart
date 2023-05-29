import 'package:aaacyborg/screens/my_campaign_screen.dart';
import 'package:aaacyborg/screens/store_sceen.dart';
import 'package:aaacyborg/screens/youtube_video_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  int _selectedIndex = 1;

  static  List<Widget> _widgetOptions = <Widget>[
    MyCampaignScreen(),
    YouTubePlayerScreen(),
    StoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Text(
            "AAACYBORG",
          ),
        ),
        leading: const Icon(Icons.ac_unit, size: 30, color: Colors.white70),
        actions: const [
          Center(child: Text("600", textAlign: TextAlign.center)),
          Padding(
            padding: EdgeInsets.all(6.0),
            child:Image(
                image: AssetImage(CustomImages.diamond),
                width: 30),
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Store',
          ),
        ],
        currentIndex: _selectedIndex,
      //  selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

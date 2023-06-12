import 'package:aaacyborg/screens/home_screen.dart';
import 'package:aaacyborg/screens/store_sceen.dart';
import 'package:aaacyborg/screens/youtube_video_screen.dart';
import 'package:aaacyborg/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  int _selectedIndex = 1;
  dynamic _points = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const WebviewtubeDemo(),
    const StoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    super.initState();
    _getData();
  }

  ///Token From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic point = prefs.getInt('point');

    setState(() {
      _points = point ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Text(
            "AAACYBORG",
          ),
        ),
        actions: [
          Center(child: Text("$_points", textAlign: TextAlign.center)),
          const Padding(
            padding: EdgeInsets.all(6.0),
            child:Image(
                image: AssetImage(CustomImages.diamond),
                width: 30),
          )
        ],
      ),*/
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webviewtube/webviewtube.dart';

import '../controller/watch_video_controller.dart';

///API Key From Google : AIzaSyAys51gpxTV9xaZUngaL-2-kuo2LqLNyfs
/*class YouTubePlayerScreen extends StatefulWidget {
  const YouTubePlayerScreen({Key? key}) : super(key: key);

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'Gv88LKWZ2j8',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              onReady: () {
                if (kDebugMode) {
                  print('Player is ready.');
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: <Widget>[
                  ///watch video new
                  Expanded(
                    flex: 4,
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
                  ),

                  ///Privacy policy
                  Expanded(
                    flex: 6,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

class WebviewtubeDemo extends StatefulWidget {
  const WebviewtubeDemo({Key? key}) : super(key: key);

  @override
  State<WebviewtubeDemo> createState() => _WebviewtubeDemoState();
}

class _WebviewtubeDemoState extends State<WebviewtubeDemo> {
  final WatchVideoController watchVideoController = Get.put(WatchVideoController());
  final controller = WebviewtubeController();
  dynamic _message = '';
  dynamic _requiredWatchSeconds = '';
  dynamic _pointsWatchVideo = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  ///Token From Api
  Future<void> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic message = prefs.getString('message');
    dynamic requiredWatchSeconds = prefs.getInt('required_watch_seconds');
    dynamic pointsWatchVideo = prefs.getInt('pointsWatchVideo');

    setState(() {
      _message = message ?? '';
      _requiredWatchSeconds = requiredWatchSeconds ?? 0;
      _pointsWatchVideo = pointsWatchVideo ?? 0;
    });
  }

  ///option given by webviewtube
  final options = const WebviewtubeOptions(showControls: true,startAt: 1,endAt: 10,
      mute: true, autoPlay: true, forceHd: true, loop: true);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isChecked = false;
  late bool autoplay;

  bool autoPlay1() {
    if (isChecked == true) {
      return true;
    } else {
      return false;
    }
  }

  final List<String> _ids = [
    'gQDByCdjUXw',
    'nPt8bK2gbaU',
    "Bvbjt_1-E0w",
    'iLnmTe5Q2Qw',
    '_WoCV4c6XOE',
    'KmzdUe0RSJo',
    '6jZDSSZZxjQ',
    'p2lYr3vM_1w',
    '7QUtEmBT_-w',
    '34_PXCzGw1M',
  ];

  /*void _addVideoEventListeners() {
    controller.nextVideo(); evaluateJavascript('''
      var video = document.querySelector('video');

      function handleVideoStarted() {
        window.flutter_inappwebview.callHandler('videoStarted');
      }

      function handleVideoStopped() {
        window.flutter_inappwebview.callHandler('videoStopped');
      }

      function handleVideoFinished() {
        window.flutter_inappwebview.callHandler('videoFinished');
      }

      if (video) {
        video.addEventListener('play', handleVideoStarted);
        video.addEventListener('pause', handleVideoStopped);
        video.addEventListener('ended', handleVideoFinished);
      }
    ''');

  void player = WebviewtubePlayer(
    videoId: _ids.first,
    options: options,
    controller: controller,
      );*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AAACYBORG") , automaticallyImplyLeading: true , centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),

            ///YouTube
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 500,
                child: WebviewtubePlayer(
                  videoId: _ids.first,
                  options: options,
                  controller: controller,
                ),
              ),
            ),

            /// auto play + text
            Row(
              children: <Widget>[
                ///auto Play
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          const Text(
                            'auto play',
                            style: TextStyle(fontSize: 18),
                          ),
                          Switch(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),

                ///Text
                const Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      height: 70,
                      child: Text(
                          "( Turn on automatic dialing and get 20% reduction in points )",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),

            ///Second + point
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Row(
                children: <Widget>[
                  ///Second
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        child: Text("$_requiredWatchSeconds Sec",
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),

                  ///Point
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        child: Text("$_pointsWatchVideo Point",
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///btnOther
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Watch other",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )))
          ],
        ),
        /* ],*/
      ),
    );
  }
}

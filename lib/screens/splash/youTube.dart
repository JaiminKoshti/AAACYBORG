import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(YouTubePlayerScreen());
}

class YouTubePlayerScreen extends StatefulWidget {
  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();

    // Replace 'VIDEO_ID_HERE' with the actual YouTube video ID
    _controller = YoutubePlayerController(
      initialVideoId: 'Gv88LKWZ2j8',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        useHybridComposition: true
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Stack(
            children: [
              YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
                onReady: () {
                  print('Player is ready.');
                },
                onEnded: (_) {
                  print('Video ended.');
                },
                /*onReady: () {
                  print('Video playing.');
                },*/
                /*onPlayerInitialized: (controller) {
                  _controller = controller;
                },*/
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _isFullScreen
                    ? Container()
                    : Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'View Count: 100',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _isFullScreen
                    ? Container()
                    : Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.fullscreen),
                        color: Colors.white,
                        onPressed: _toggleFullScreen,
                      ),
                      IconButton(
                        icon: Icon(Icons.settings),
                        color: Colors.white,
                        onPressed: () {
                          // Show quality and speed options
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
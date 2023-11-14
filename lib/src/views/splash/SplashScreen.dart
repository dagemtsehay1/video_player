import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/videos.dart';
import '../../views/ui/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<List<Video>> videoData;

  @override
  void initState() {
    super.initState();
    videoData = fetchVideoData();

    videoData.then((videos) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(videos: videos),
        ),
      );
    }).catchError((error) {
      print(error);
    });
  }

  Future<List<Video>> fetchVideoData() async {
    try {
      final response =
          await http.get(Uri.parse('https://app.et/devtest/list.json'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        final List<dynamic> decodedVideos = decodedJson["videos"];
        final List<Video> videos = decodedVideos
            .map((videoJson) => Video.fromJson(videoJson))
            .toList();
        print(videos);
        await storeVideoDataLocally(videos);
        return videos;
      } else {
        print("nooo");
        return getStoredVideoDataLocally();
      }
    } catch (e) {
      print("err");
      print(e);
      return getStoredVideoDataLocally();
    }
  }

  Future<void> storeVideoDataLocally(List<Video> videos) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(videos);
    prefs.setString('videoData', jsonString);
  }

  Future<List<Video>> getStoredVideoDataLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final storedVideoDataString = prefs.getString('videoData');
    if (storedVideoDataString != null) {
      final List<Video> storedVideoData =
          (json.decode(storedVideoDataString) as List)
              .map((videoJson) => Video.fromJson(videoJson))
              .toList();
      return storedVideoData;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: const [
                    Text("Splash Screen"),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Developed by Dagem Tsehay"),
                )
              ]),
        ),
      ),
    );
  }
}

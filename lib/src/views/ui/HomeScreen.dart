import 'package:flutter/material.dart';

import '../../models/videos.dart';
import 'VideoPlayerScreen.dart';

class HomeScreen extends StatelessWidget {
  final List<Video> videos;

  const HomeScreen({super.key, required this.videos});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Player"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(videos[index].videoTitle ?? ""),
            subtitle: Text(videos[index].videoDescription ?? ""),
            leading: Image.network(
              videos[index].videoThumbnail ?? "",
              errorBuilder: (context, error, stackTrace) {
                // Handle thumbnail not found
                return const Icon(Icons.error);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                    videoUrl: videos[index].videoUrl ?? "",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeThumbnail extends StatelessWidget {
  final String youtubeUrl;

  YouTubeThumbnail({required this.youtubeUrl});

  String _extractVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:https?://)?(?:www\.)?(?:youtube\.com/(?:[^/]+/)?(?:v|e|u|embed|watch)?/|youtu\.be/)([^&?]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match != null ? match.group(1)! : '';
  }

  @override
  Widget build(BuildContext context) {
    String videoId = YoutubePlayer.convertUrlToId(youtubeUrl)??"";
    String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return videoId.isNotEmpty
        ? Image.network(thumbnailUrl,fit: BoxFit.fill,)
        : const Text('Invalid YouTube URL');
  }
}
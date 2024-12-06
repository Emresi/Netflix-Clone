import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({required this.videoUrl, super.key});
  final String videoUrl;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;
  bool isPlaying = false;
  bool isCaptionsEnabled = true;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        controlsVisibleAtStart: true,
      ),
    );

    // Force landscape mode and full-screen behavior
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller.addListener(() {
      setState(() {
        isPlaying = _controller.value.isPlaying;
      });
    });
  }

  // Toggle between play and pause
  void togglePlayPause() {
    if (isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  // Fast forward the video by 10 seconds
  void fastForward() {
    final currentPosition = _controller.value.position.inSeconds;
    final duration = _controller.metadata.duration.inSeconds;
    final newPosition = currentPosition + 10;

    if (newPosition < duration) {
      _controller.seekTo(Duration(seconds: newPosition));
    } else {
      _controller.seekTo(Duration(seconds: duration));
    }
  }

  // Rewind the video by 10 seconds
  void rewind() {
    final currentPosition = _controller.value.position.inSeconds;
    final newPosition = currentPosition - 10;

    if (newPosition > 0) {
      _controller.seekTo(Duration(seconds: newPosition));
    } else {
      _controller.seekTo(Duration.zero);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: isPlaying
          ? null
          : IconButton.filled(
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(backgroundColor: Colors.red),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
      body: Stack(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            onReady: () {
              // Controller is ready to be used
            },
          ),
          Align(
            child: AnimatedOpacity(
              opacity: isPlaying ? 0 : 1,
              duration: Durations.short4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.replay_10, size: 30),
                      onPressed: rewind,
                    ),
                    IconButton(
                      icon: const Icon(Icons.forward_10, size: 30),
                      onPressed: fastForward,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

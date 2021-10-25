import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PostVideoplayer extends StatefulWidget {
  PostVideoplayer({Key key, this.mediaUrl}) : super(key: key);
  final String mediaUrl;
  @override
  _PostVideoplayerState createState() => _PostVideoplayerState();
}

class _PostVideoplayerState extends State<PostVideoplayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.mediaUrl,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  playPoseVideo() {
    setState(() {
      // If the video is playing, pause it.
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        // If the video is paused, play it.
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
        children: [
          GestureDetector(
              child: Container(
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _width * 0.9,
                            height: _height,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
              onTap: () {
                playPoseVideo();
              }),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      )),
    );
  }
}

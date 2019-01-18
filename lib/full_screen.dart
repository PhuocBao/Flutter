import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/custom_player.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:video_player/video_player.dart';

class FullScreen extends StatefulWidget {
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    final _videoBloc = UserProvider.of(context);
    return Scaffold(
          body: StreamBuilder<VideoPlayerController>(
          stream: _videoBloc.video,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Hero(
                tag: 'full_screen',
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CustomPlayer().createState().customPlayer(snapshot.data),
                ),
              );
            } else {
              return Hero(tag: 'full_screen', child: Container());
            }
          }),
    );
  }
}

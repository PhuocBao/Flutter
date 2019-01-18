import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/full_screen.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/video_session.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class CustomPlayer extends StatefulWidget {
  final videoUrl;

  CustomPlayer({Key key, this.videoUrl}) : super(key: key);

  _CustomPlayerState createState() => _CustomPlayerState();
}

class _CustomPlayerState extends State<CustomPlayer>
    with SingleTickerProviderStateMixin {
  AnimationController _animationControllerIcon;
  VideoPlayerController _playerController;
  Animation<double> _animation;
  final VideoSession _videoSession = VideoSession();
  bool _isPlaying = false;
  int currentMinute = 0;
  String currentSecond = '00';

  String convertToJson(VideoSession videoSession) {
    final currentTime = DateTime.now();
    print(currentTime);
    final formatTime = DateFormat('Hms').format(currentTime);
    final newTimes = formatTime.split(':');
    //newTimes include 3 element (hour:minute:second)
    //oldTimes = _videoSession.systemTime.split(":");
    //caculate timestamp:
    //timeStamp = newTime - oldTime = (newTimes[0] * 3600 + newTimes[1] * 60 + newTimes[2]) - (oldTimes[0] * 3600 + oldTimes[1] * 60 + oldTimes[2])
    // if (timeStamp > _playerController.value.duration.inSeconds) => move to next video or watch again
    // else videoSession.currentPosition + timeStamp
    // final videoSession = VideoSession(
    //     id: 1,
    //     systemTime: formatTime,
    //     videoLength: _playerController.value.duration.inSeconds,
    //     videoName: 'music',
    //     currentPosition: _playerController.value.position.inSeconds,
    //     isPlaying: _isPlaying);
    // print(videoSession.systemTime);
    print(formatTime);
    return jsonEncode(videoSession.toJson());
  }

  void _setCurrentTime() {
    setState(() {
      currentMinute = (_playerController.value.position.inSeconds / 60).floor();
      if ((_playerController.value.position.inSeconds % 60) < 10) {
        currentSecond = '0${(_playerController.value.position.inSeconds % 60)}';
      } else {
        currentSecond =
            (_playerController.value.position.inSeconds % 60).toString();
      }
    });
  }

  @override
  void initState() {
    _animationControllerIcon =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationControllerIcon);
    _playerController = VideoPlayerController.asset(widget.videoUrl)
      ..setLooping(true)
      ..addListener(
        () {
          if (!_playerController.value.isPlaying) {
            _setCurrentTime();
            // convertToJson(_videoSession);
          } else if (_playerController.value.isPlaying) {
            _setCurrentTime();
          }
        },
      )
      // ..initialize().whenComplete(() => convertToJson(_videoSession));
      ..initialize();
    _playerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _playerController.value.initialized
        ? customPlayer(_playerController)
        : Image.asset('images/place_holder.jpg');
  }

  Widget customPlayer(VideoPlayerController controller) {
    controller = _playerController;
    final _videoBloc = UserProvider.of(context);
    return Container(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'full_screen',
              child: VideoPlayer(controller),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Slider(
                    activeColor: Colors.red,
                    inactiveColor: Colors.white,
                    value: controller.value.position.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _playerController
                            .seekTo(Duration(seconds: value.toInt()));
                      });
                    },
                    //
                    max: controller.value.initialized
                        ? controller.value.duration.inSeconds.toDouble()
                        : 0.0,
                    min: 0.0,
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: AnimatedIcon(
                          icon: AnimatedIcons.pause_play,
                          color: Colors.white,
                          progress: _animation,
                        ),
                        onPressed: () {
                          if (!_isPlaying) {
                            controller.pause();
                            _animationControllerIcon.forward();
                            _isPlaying = true;
                          } else {
                            controller.play();
                            _animationControllerIcon.reverse();
                            _isPlaying = false;
                          }
                        },
                      ),
                      _customIconButton(Icons.skip_next, 20.0, () {}),
                      _customIconButton(Icons.volume_up, 36.0, () {}),
                      Expanded(
                        child: Text(
                          '$currentMinute:$currentSecond',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      _customIconButton(
                        Icons.zoom_out_map,
                        36.0,
                        () {
                          _videoBloc.saveCurrentState(controller);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreen()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customIconButton(IconData icon, double size, VoidCallback onPress) {
    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPress,
    );
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }
}

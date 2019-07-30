import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_bottomappbar/model/SoundCloud.dart';
import 'package:flutter_demo_bottomappbar/model/Tracks.dart';

class SecondScreen extends StatefulWidget {
  final Tracks tracks;
  final SoundCloud soundCloud;

  const SecondScreen(
      {Key key, @required this.tracks, @required this.soundCloud})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecondScreenState(tracks, soundCloud);
  }
}

class SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  final Tracks tracks;
  final SoundCloud soundCloud;
  final AudioPlayer audioPlayer = new AudioPlayer();
  final String url = "https://api.soundcloud.com/tracks/";
  final String clientID = "/stream?client_id=78dchKObuQOVMxWv33j9yHzet49YEfLZ";
  var _sliderValue = 0.0;
  //false mean icon button pause
  //true mean icon button play
  bool _isPlayMusic = false;

  SecondScreenState(this.tracks, this.soundCloud);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.network(tracks.artworkUrl).image,
                    fit: BoxFit.cover)),
            child: Stack(
              children: <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
                Column(
                  children: <Widget>[
                    AppBar(
                      title: Text(tracks.title),
                      brightness: Brightness.dark,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              audioPlayer.release();
                            });
                          }),
                    ),
                    Flexible(
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Hero(
                            tag: 'hero + ${tracks.artworkUrl}',
                            child: Container(
                              margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
                              child: Image.network(
                                tracks.artworkUrl,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Slider(
                              value: _sliderValue,
                              max: tracks.duration.toDouble(),
                              min: 0.0,
                              activeColor: Colors.white,
                              onChanged: (position) {
                                setState(() {
                                  _sliderValue = position;
                                  audioPlayer.seek(new Duration(
                                      milliseconds: position.toInt()));
                                });
                              },
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              _createButton(Icon(Icons.skip_previous), () {}),
//                              _createButton(
//                                  Icon(_isPlayMusic
//                                      ? Icons.pause
//                                      : Icons.play_arrow),
//                                      () => _togglePlay()),
                              FloatingActionButton(
                                onPressed: () => _togglePlay(),
                                backgroundColor: Colors.white,
                                child: Icon(
                                  _isPlayMusic ? Icons.pause : Icons.play_arrow,
                                  color: Colors.black,
                                ),
                              ),
                              _createButton(Icon(Icons.skip_next), () {}),
                            ],
                          ),
                        ],
                      )),
                      fit: FlexFit.loose,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget _createButton(Icon icon, VoidCallback onPress) {
    return IconButton(icon: icon, color: Colors.white, onPressed: onPress);
  }

  _togglePlay() async {
    int result = await audioPlayer.play(url + tracks.id.toString() + clientID,
        isLocal: false);
    //result = 1 && isPlay = false
    if (result == 1 && !_isPlayMusic) {
      _isPlayMusic = true;
    } else {
      _isPlayMusic = false;
    }

    setState(() {
      //isPlay = true => resume else pause
      if (_isPlayMusic) {
        //when click button again the comparison will run into else => pause music
        audioPlayer.resume();
      } else {
        audioPlayer.pause();
        _isPlayMusic = false;
      }
    });
  }
}

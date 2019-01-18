import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/custom_player.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart' as input;
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<DiscoverScreen> {
  final videosUrl = [
    'videos/music.mp4',
    'videos/sioux1.mp4',
    'videos/sioux2.mp4'
  ];
  final List<Widget> videos = List();

  @override
  Widget build(BuildContext context) {
    int _index = 1;
    return UserProvider(
          child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(AppBar().preferredSize.width, 120.0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
              flexibleSpace: Center(
                child: Text(
                  'Something about us',
                  style: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Swiper(
                      itemCount: 3,
                      autoplay: false,
                      controller: SwiperController(),
                      index: _index,
                      onIndexChanged: (index) {
                        _index = index;
                        print(_index);
                      },
                      itemBuilder: (context, index) {
                        if (index == _index) {
                          return CustomPlayer(videoUrl: videosUrl[_index],);
                        } else {
                          return Image.asset('images/place_holder.jpg');
                        }
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  input.exitSection(context),
                  WelcomeScreen()
                      .createState()
                      .navigateButton('Provide feedback', () {})
                ],
              )
            ],
          )),
    );
  }
}

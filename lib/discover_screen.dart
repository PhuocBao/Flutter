import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/custom_player.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart';
import 'package:flutter_demo_wireframe_design/user_bloc.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_demo_wireframe_design/welcome_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';

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

  @override
  Widget build(BuildContext context) {
    int _index = 1;
    return BlocProvider(
      bloc: UserBloc(),
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
                        // print('index pos: $_index');
                      },
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          child: index == _index
                              ? CustomPlayer(
                                  videoUrl: videosUrl[_index],
                                )
                              : Image.asset('images/place_holder.jpg'),
                          borderRadius: BorderRadius.circular(8.0),
                        );
                      },
                      viewportFraction: 0.83,
                      scale: 0.9,
                    ),
                  ),
                ),
              ),
              Text(
                'Sioux - We bring high-tech to life',
                style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 24.0),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: DotsIndicator(
                  numberOfDot: videosUrl.length,
                  dotActiveColor: Color(0xFF4F4F4F),
                  dotSize: Size.square(8.0),
                  dotActiveSize: Size.square(8.0),
                  position: _index,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CheckinScreen().createState().exitSection(context),
                  WelcomeScreen()
                      .createState()
                      .navigateButton('Provide feedback', () {})
                ],
              ),
            ],
          )),
    );
  }
}

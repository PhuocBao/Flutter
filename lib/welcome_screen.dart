import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/discover_screen.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/user_provider.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart' as input;
import 'constants.dart';

class WelcomeScreen extends StatefulWidget {
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _profileSection(context),
          Container(
            margin: const EdgeInsets.only(top: 100.0, bottom: 160.0),
            child: VerticalDivider(
              color: Colors.black,
            ),
          ),
          _whoInCharge(context),
        ],
      ),
    );
  }

  _whoInCharge(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4 - 16.0,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Hi, you are going to meet',
                style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 48.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'images/profile_pic.jpg',
                    height: 160.0,
                    width: 160.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 26.0),
                    child: Text(
                      'Mrs. Thao Thai',
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 36.0,
                      ),
                    ),
                  ),
                  Text(
                    'HR Manager',
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 23.5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 29.0),
                    child: Text(
                      'This person have been notified you are here! Please wait a moment!',
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 36.0),
                        child: Text(
                          'This is something about Thao Thai, may be some fun facts',
                          style: TextStyle(
                            color: Color(0xFF4F4F4F),
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            navigateButton(
                'Discover Sioux',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DiscoverScreen())))
          ],
        ),
      ),
    );
  }

  Widget _profileSection(BuildContext context) {
    final _userBloc = UserProvider.of(context);
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StreamBuilder<User>(
                    stream: _userBloc.user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int spacePos = snapshot.data.name.indexOf(' ');
                        String animalName =
                            snapshot.data.name.substring(spacePos + 1);
                        for (var i = 0; i < kAnimalAvatar.length; i++) {
                          if (kAnimalAvatar
                                  .elementAt(i)
                                  .contains(animalName, 16) ==
                              true) {
                            return Image.asset(
                              kAnimalAvatar.elementAt(i),
                              width: 160.0,
                              height: 160.0,
                            );
                          }
                        }
                      } else {
                        return Container();
                      }
                    }),
                StreamBuilder<User>(
                  stream: _userBloc.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: const EdgeInsets.only(top: 20.0, left: 5.0),
                        child: Text(
                          '${snapshot.data.name}',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                StreamBuilder<User>(
                  stream: _userBloc.user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          snapshot.data.role,
                          style: TextStyle(
                              color: Color(0xFF828282), fontSize: 23.5),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                Text(
                  'Edit profile',
                  style: TextStyle(color: Color(0xFF4F4F4F), fontSize: 18.0),
                ),
              ],
            ),
          ),
          input.exitSection(context)
        ],
      ),
    );
  }

  Widget navigateButton(String label, VoidCallback onPress) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 8.0),
        child: RaisedButton(
          color: Color(0xFF828282),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              )
            ],
          ),
          onPressed: onPress,
        ),
      ),
    );
  }
}

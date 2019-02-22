import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/appbar_main.dart';
import 'package:flutter_demo_wireframe_design/button_border.dart';
import 'package:flutter_demo_wireframe_design/constants.dart';
import 'package:flutter_demo_wireframe_design/custom_hero_transition.dart';
import 'package:flutter_demo_wireframe_design/discover_screen.dart';
import 'package:flutter_demo_wireframe_design/home_transition.dart';
import 'package:flutter_demo_wireframe_design/input_name.dart';
import 'package:flutter_demo_wireframe_design/main.dart';
import 'package:flutter_demo_wireframe_design/translations.dart';
import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:flutter_demo_wireframe_design/visit_purpose.dart';

class WelcomeScreen extends StatefulWidget {
  final User user;

  const WelcomeScreen({Key key, this.user}) : super(key: key);

  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _avatarUrl;
  @override
  void initState() {
    int spacePos = widget.user.name.indexOf(' ');
    String animalName = widget.user.name.substring(spacePos + 1);
    if (widget.user.name.contains('Anonymous')) {
      for (var i = 0; i < kAnimalAvatar.length; i++) {
        if (kAnimalAvatar.elementAt(i).contains(animalName.toLowerCase(), 16) ==
            true) {
          _avatarUrl = kAnimalAvatar.elementAt(i);
          break;
        }
      }
    } else {
      _avatarUrl = 'images/anonymous_bear.png';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _userBloc = UserProvider.of(context);
    // _userBloc.addAvatar(_avatarUrl);
    return Scaffold(
      backgroundColor: Color(0xFFF68B1F),
      body: Column(
        children: <Widget>[
          AppBarMain(
            content: Translations.of(context).text('wc_app_bar'),
            leadingText: Translations.of(context).text('back'),
            isImplyLeading: true,
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            child: Container(
              height: MediaQuery.of(context).size.height - 128.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
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
            ),
          ),
        ],
      ),
    );
  }

  _whoInCharge(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 3 / 4 - 16.0,
      height: MediaQuery.of(context).size.height - 128.0,
      margin: EdgeInsets.only(top: 60.0),
      child: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'images/profile_pic.jpg',
                    height: 160.08,
                    width: 160.08,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 26.0, bottom: 12.0),
                    child: Text(
                      'Mrs. Thao Thai',
                      style: TextStyle(
                        color: Color(0xFF4F4F4F),
                        fontSize: 36.0,
                      ),
                    ),
                  ),
                  Text(
                    Translations.of(context).text('wc_in_charge_role'),
                    style: TextStyle(
                      color: Color(0xFFF15D03),
                      fontSize: 23.5,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 38.0),
                    child: Text(
                      Translations.of(context).text('wc_waiting_text'),
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
                Translations.of(context).text('discover_sioux'),
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DiscoverScreen())))
          ],
        ),
      ),
    );
  }

  Widget _profileSection(BuildContext context) {
    // final _userBloc = UserProvider.of(context);
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height - 128.0,
      margin: EdgeInsets.only(top: 60.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Hero(
                  tag: widget.user.avatar,
                  child: Image.asset(
                    _avatarUrl,
                    height: 160.08,
                  ),
                ),
                Container(
                  //margin: const EdgeInsets.only(top: 10.0),
                  child: Hero(
                    tag: widget.user.name,
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) {
                      return ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(begin: 36.0 / 24.0, end: 1.0).chain(
                            CurveTween(
                              curve: Curves.ease,
                            ),
                          ),
                        ),
                        child: Scaffold(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
                          body: Container(
                            alignment: Alignment(0, 0),
                            child: SingleChildScrollView(
                              child: toHeroContext.widget,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Text(
                        widget.user.name,
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    widget.user.role == null ? '' : widget.user.role,
                    style: TextStyle(
                        color: Color(widget.user.role == 'Guest' ||
                                widget.user.role == 'Khách hàng'
                            ? 0xFF70BF43
                            : 0xFF00AEEF),
                        fontSize: 23.5),
                  ),
                ),
                ButtonBorder(
                  content: Translations.of(context).text('wc_edit_profile'),
                  callback: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CheckinScreen())),
                ),
              ],
            ),
          ),
          VisitPurpose().createState().exitSection(context)
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

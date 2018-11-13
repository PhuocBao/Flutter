import 'package:flutter/material.dart';
import 'package:my_music/activity/FavoriteActivity.dart';
import 'package:my_music/activity/HomeActivity.dart';
import 'package:my_music/activity/ProfileActivity.dart';

void main() => runApp(MainActivity());

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainActivityState();
  }
}

class MainActivityState extends State<MainActivity> {
  int _currentIndex = 0;
  final List<Widget> tabs = [Home(), Favorite(), Profile()];

  void _onTapChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: tabs.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            new BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            new BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text("Favorite")),
            new BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text("Profile")),
          ],
          fixedColor: Colors.purpleAccent,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onTapChange,
        ),
      ),
    );
  }
}

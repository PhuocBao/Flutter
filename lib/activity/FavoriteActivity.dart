import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  final _tabCount = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: _tabCount,
            child: Scaffold(
                appBar: AppBar(
                  bottom: TabBar(tabs: <Tab>[
                    new Tab(icon: Icon(Icons.mail)),
                    new Tab(icon: Icon(Icons.collections_bookmark)),
                    new Tab(icon: Icon(Icons.music_note),
                    )
                  ]),
                ),
              body: TabBarView(children: <Widget>[new Tab(icon: Icon(Icons.mail)),
          new Tab(icon: Icon(Icons.collections_bookmark)),
          new Tab(icon: Icon(Icons.music_note))],),
            )
        )
    );
  }
}

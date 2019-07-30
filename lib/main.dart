import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_demo_bottomappbar/model/SoundCloud.dart';
import 'package:flutter_demo_bottomappbar/model/Tracks.dart';
import 'package:flutter_demo_bottomappbar/screen/SecondScreen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  SoundCloud _soundCloud;

  Future<List<Tracks>> _fetchMusic() async {
    final response = await http.get(
        "https://api-v2.soundcloud.com/playlists/51957607?representation=full&client_id=8MIyp4EkamnXpXME8Wkc3nmGY7h5dnTy&app_version=1564401410&app_locale=en");
    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      _soundCloud = SoundCloud.fromJson(responseMap);
      List<Tracks> _tracks = _soundCloud.tracks;
      return _tracks;
    } else {
      throw Exception('Failed to load post');
    }
  }

  GestureDetector _displayList(BuildContext context, Tracks track) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'hero + ${track.artworkUrl}',
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                child: ClipRRect(
                  child: Image.network(
                    track.artworkUrl,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            Container(
                child: Flexible(
                    child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    track.title,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  track.user.username,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )))
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondScreen(
                      tracks: track,
                      soundCloud: _soundCloud,
                    )));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(),
        appBar: PreferredSize(
            child: Container(
              color: Colors.purple,
              child: ListView(
                children: <Widget>[
                  AppBar(
                    title: Text("Home"),
                    centerTitle: true,
                    backgroundColor: Colors.purple,
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                    ],
                    flexibleSpace: Container(
                        margin: EdgeInsets.only(
                            top: AppBar().preferredSize.height,
                            left: 8.0,
                            right: 8.0,
                            bottom: 8.0),
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0))),
                            child: TextField(
                              autocorrect: false,
                              maxLines: 1,
                              enableInteractiveSelection: false,
                              autofocus: false,
                              textInputAction: TextInputAction.search,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.keyboard_voice,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {})),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            preferredSize: Size(AppBar().preferredSize.width,
                AppBar().preferredSize.height * 2 + 8)),
        body: FutureBuilder<List<Tracks>>(
            future: _fetchMusic(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print("error" + snapshot.error.toString());
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
//                    padding: EdgeInsets.all(10.0),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return _displayList(
                          context, snapshot.data.elementAt(index));
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

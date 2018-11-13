import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  final Set<String> sets = new Set();

  ListTile _listItems(String name) {
    bool _isFavorite = sets.contains(name);
    _toggleFavorite() {
      setState(() {
        if (_isFavorite) {
          sets.remove(name);
          _isFavorite = false;
        } else {
          sets.add(name);
          _isFavorite = true;
        }
      });
    }

    return ListTile(
      title: Text(name),
      trailing: IconButton(
          icon:
              _isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: _toggleFavorite),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> listItems = new List();
    listItems.add("Using the standard ListView constructor is perfect");
    listItems.add("for lists that contain only a few items. We will also ");
    listItems.add("Album");
    listItems.add("Phone");
    listItems.add("Basic");
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _listItems(listItems.elementAt(index));
            },
            itemCount: listItems.length,
            scrollDirection: Axis.vertical,
            addAutomaticKeepAlives: true,
          )),
    );
  }
}

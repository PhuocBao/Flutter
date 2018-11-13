import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_music/activity/ProfileActivity.dart';
import 'package:my_music/model/Movie.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final String imgURL = "http://image.tmdb.org/t/p/w185";

  //use GestureDetector to tap on List Item
  GestureDetector listItems(Movie movie) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        });
      },
      child: Row(
        verticalDirection: VerticalDirection.down,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          //use container to wrap image
          Container(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              //use cliprrect to border image
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Image.network(
                    imgURL + movie.mImg,
                    width: 100.0,
                    height: 150.0,
                  ))),
          //use flexible to display text widget with multi line
          Flexible(
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  movie.mName,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }

  GridView _gridView(List<Movie> movies) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: movies.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 5.0),
                //use cliprrect to border image
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    child: Image.network(imgURL + movies.elementAt(index).mImg,
                        width: 100.0, height: 150.0))),
            //use flexible to display text widget with multi line
            Flexible(
              child: Container(
                child: Text(
                  movies.elementAt(index).mName,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]);
        });
  }

  Future<List<Movie>> _fecthMovie(http.Client client) async {
    final response = await client.get(
        "https://api.themoviedb.org/3/movie/popular?api_key=8ec3fbf1c1b06d940e29c592421917ae&language=en-US&page=1");
    if (response.statusCode == 200) {
      //convert json to Map<String, dynamic>: dynamic is the value that content many type of value (String, int, list...)
      Map<String, dynamic> results = jsonDecode(response.body);
      //point to result element by results['results'] and cast Map<String, dynamic> to parse data to Movie class
      final movies = results['results'].cast<Map<String, dynamic>>();
      List<Movie> movieList = movies.map<Movie>((json) {
        return Movie.fromJson(json);
      }).toList();
      return movieList;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isScroll) {
              //headerSliverBuilder return to list of widget
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  pinned: true,
                  title: Text("Home"),
                  backgroundColor: Colors.purpleAccent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ];
            },
            body: FutureBuilder<List<Movie>>(
              future: _fecthMovie(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
//                  return ListView.builder(itemBuilder: (BuildContext context, int index) {
//                    return listItems(snapshot.data.elementAt(index));
//                  });
                  return _gridView(snapshot.data);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )));
  }
}

import 'package:flutter/material.dart';
import 'main.dart' as main;

class NextPage extends StatefulWidget {
  final result, suggest;

  NextPage(this.result, this.suggest);

  _NextPageState createState() => _NextPageState(result, suggest);
}

class _NextPageState extends State<NextPage> {
  final result, suggest;
  _NextPageState(this.result, this.suggest);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Next Page"),),
      body: Column(
        children: <Widget>[
        main.ResultSection(result, suggest),
        ],
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomHeroTransition extends StatelessWidget {
  final String imageUrl;
  final String name;

  const CustomHeroTransition({Key key, this.imageUrl, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // timeDilation = 5.0;
    return Hero(
      tag: imageUrl,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            imageUrl,
            height: 160.08,
            width: 160.08,
          ),
          Container(
            margin: EdgeInsets.only(top: 23.95,bottom: 6.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

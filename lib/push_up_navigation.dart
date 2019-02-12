import 'package:flutter/material.dart';

class PushUpNavigation extends PageRouteBuilder {
  final Widget widget;

  PushUpNavigation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 700),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)
                  .animate(
                CurvedAnimation(parent: animation, curve: Curves.linear),
              ),
              child: widget,
            );
          },
        );
}

import 'package:flutter/material.dart';

class SlideLeftNavigation extends PageRouteBuilder {
  final Widget widget;

  SlideLeftNavigation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                  .animate(
                CurvedAnimation(parent: animation, curve: Curves.linear),
              ),
              child: widget,
            );
          },
        );
}

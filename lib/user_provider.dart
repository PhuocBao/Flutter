import 'package:flutter/material.dart';
import 'package:flutter_demo_wireframe_design/user_bloc.dart';

class UserProvider extends InheritedWidget {
  final UserBloc _userBloc = UserBloc();

  UserProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UserProvider) as UserProvider)
        ._userBloc;
  }
}

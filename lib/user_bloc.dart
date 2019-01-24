import 'dart:async';

import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class UserBloc {
  User _user = User();

  Observable<User> get user => _userController.stream;
  final _userController = BehaviorSubject<User>();

  Observable<VideoPlayerController> get video => _videoController.stream;
  final _videoController = BehaviorSubject<VideoPlayerController>();

  Future<void> saveCurrentState(VideoPlayerController controller) async {
    _videoController.add(controller);
  }

  Future<void> addUserName(String name) async {
    _user.name = name;
    _userController.add(_user);
  }

  Future<void> addRole(String role) async {
    _user.role = role;
    _userController.add(_user);
  }

  void dispose() {
    _userController.close();
  }
}

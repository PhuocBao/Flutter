import 'dart:async';

import 'package:flutter_demo_wireframe_design/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  User _user = User();
  List<User> _users = List();
  // Translations _translations = Translations(Locale('en'));

  Observable<User> get user => _userController.stream;
  final _userController = BehaviorSubject<User>();

  Observable<List<User>> get users => _usersController.stream;
  final _usersController = PublishSubject<List<User>>();

  // Observable<Translations> get language => _languageController.stream;
  // final _languageController = BehaviorSubject<Translations>();

  Future<void> addUserName(String name) async {
    _user.name = name;
    _userController.add(_user);
  }

  Future<void> addRole(String role) async {
    _user.role = role;
    _userController.add(_user);
  }

  Future<void> addAvatar(String avatarUrl) async {
    _user.avatar = avatarUrl;
    _userController.add(_user);
  }

  Future<void> addUser() async {
    // if (_users.isEmpty) {
    //   _users.add(user);
    //   _usersController.add(_users);
    // } else {
    //   _users.add(user);
    //   _usersController.add(_users);
    //   // final temps = _users;
    //   // _users.clear();
    //   // temps.add(_user);
    //   // _users = temps;
    //   // _users.insert(0, _user);
    // }
    _users.add(_user);
    _usersController.onAdd(_users);
    for (var item in _users) {
      print(item.name);
    }
  }

  // Future<void> changeLanguage(bool isEnglish) async {
  //   if (isEnglish) {
  //     _languageController.add(await Translations.load((Locale('en'))));
  //   } else {
  //     _languageController.add(await Translations.load((Locale('vi'))));
  //   }
  // }

  void dispose() {
    _userController.close();
    _usersController.close();
    // _languageController.close();
  }
}

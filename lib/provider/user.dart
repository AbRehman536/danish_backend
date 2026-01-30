import 'package:danish_backend/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  ///set user
  void setUser(UserModel model){
    _userModel = model;
    notifyListeners();
  }

  ///get User
  UserModel getUser() => _userModel;
}
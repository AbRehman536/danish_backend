import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  ///Update User
  Future updateUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .update({'name': model.name, "phone": model.phone, "address": model.address});
  }

  ///Delete User
  Future deleteUser(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(model.docId)
        .delete();
  }

  ///Get User by ID
  Future<UserModel> getUserByID(String userID)async {
    return await FirebaseFirestore.instance
        .collection('UserCollection')
        .doc(userID)
        .get()
          .then((json) => UserModel.fromJson(json.data()!)
    );
  }
}
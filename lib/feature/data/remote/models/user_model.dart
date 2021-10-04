import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {String? name,
      String? email,
      String? uid,
      String? status,
      String? password})
      : super(
            name: name,
            email: email,
            uid: uid,
            status: status,
            password: password);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      name: documentSnapshot['name'],
      email: documentSnapshot['email'],
      uid: documentSnapshot['uid'],
      status: documentSnapshot['status'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "status": status,
    };
  }
}

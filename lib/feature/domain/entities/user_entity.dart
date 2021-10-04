import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? name;
  String? email;
  String? uid;
  String? status;
  String? password;

  UserEntity({this.name, this.email, this.uid, this.status, this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, uid, status, password];
}

part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

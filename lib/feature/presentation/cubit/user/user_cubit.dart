import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';
import 'package:notes_app/feature/domain/use_cases/get_current_user_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_in_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_out_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_up_uc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.signInUseCase, this.signOutUseCase,
      this.getCreateCurrentUserUseCase, this.signUpUseCase)
      : super(UserInitial());

  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  Future submitSignIn(UserEntity userEntity) async {
    print('sign in ');
    try {
      await signInUseCase.call(userEntity);
    } catch (_) {}
  }

  Future submitSignUp(UserEntity userEntity) async {
    print('submit');
    try {
      await signUpUseCase.call(userEntity);
      await getCreateCurrentUserUseCase.call(userEntity);
      emit(UserSuccess());
      print('user su');
    } catch (_) {}
  }
}

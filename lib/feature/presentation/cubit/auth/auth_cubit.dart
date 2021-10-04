import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/feature/domain/use_cases/get_current_id_uc.dart';
import 'package:notes_app/feature/domain/use_cases/is_signed_in_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_out_uc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this.getCurrentIdUseCase, this.isSignedInUseCase, this.signOutUseCase)
      : super(AuthInitial());

  final GetCurrentIdUseCase getCurrentIdUseCase;
  final IsSignedInUseCase isSignedInUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> appStarted() async {
    try {
      final isSignedIn = await isSignedInUseCase.call();
      if (isSignedIn) {
        final uid = await getCurrentIdUseCase.call();
        emit(Authenticated(uid));
      } else {
        emit(Unauthenticated());
      }
    } on SocketException catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentIdUseCase.call();
      emit(Authenticated(uid));
    } on SocketException catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
    } on SocketException catch (_) {
      emit(Unauthenticated());
    }
  }
}

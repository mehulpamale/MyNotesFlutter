import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:notes_app/feature/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:notes_app/feature/data/repositories/firebase_repository_impl.dart';
import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/use_cases/add_new_note_uc.dart';
import 'package:notes_app/feature/domain/use_cases/delete_note_uc.dart';
import 'package:notes_app/feature/domain/use_cases/get_current_id_uc.dart';
import 'package:notes_app/feature/domain/use_cases/get_current_user_uc.dart';
import 'package:notes_app/feature/domain/use_cases/get_notes_uc.dart';
import 'package:notes_app/feature/domain/use_cases/is_signed_in_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_in_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_out_uc.dart';
import 'package:notes_app/feature/domain/use_cases/sign_up_uc.dart';
import 'package:notes_app/feature/domain/use_cases/update_note_uc.dart';
import 'package:notes_app/feature/domain/use_cases/update_note_uc.dart';
import 'package:notes_app/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/notelist/note_cubit.dart';
import 'package:notes_app/feature/presentation/cubit/user/user_cubit.dart';

GetIt sl = GetIt.instance;

Future init() async {
  //cubit/bloc
  sl.registerFactory<AuthCubit>(
      () => AuthCubit(sl.call(), sl.call(), sl.call()));
  sl.registerFactory<UserCubit>(
      () => UserCubit(sl.call(), sl.call(), sl.call(), sl.call()));
  sl.registerFactory<NoteCubit>(
      () => NoteCubit(sl.call(), sl.call(), sl.call(), sl.call()));
  //usecases
  sl.registerLazySingleton<UpdateNoteUseCase>(
          () => UpdateNoteUseCase(sl.call()));
  sl.registerLazySingleton<AddNewNoteUseCase>(
      () => AddNewNoteUseCase(sl.call()));
  sl.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(sl.call()));
  sl.registerLazySingleton<GetCurrentIdUseCase>(
      () => GetCurrentIdUseCase(sl.call()));
  sl.registerLazySingleton<GetNotesUseCase>(() => GetNotesUseCase(sl.call()));
  sl.registerLazySingleton<IsSignedInUseCase>(
      () => IsSignedInUseCase(sl.call()));
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase(sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(sl.call()));
  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));
  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}

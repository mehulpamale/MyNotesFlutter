import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';
import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    return firebaseRemoteDataSource.addNewNote(noteEntity);
  }

  @override
  Future<void> deleteNewNote(NoteEntity noteEntity) async {
    return firebaseRemoteDataSource.deleteNewNote(noteEntity);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    return firebaseRemoteDataSource.getCreateCurrentUser(userEntity);
  }

  @override
  Stream<List<NoteEntity?>> getNotes(String uid) {
    return firebaseRemoteDataSource.getNotes(uid);
  }

  @override
  Future<void> signIn(UserEntity userEntity) async {
    return firebaseRemoteDataSource.signIn(userEntity);
  }

  @override
  Future<void> signUp(UserEntity userEntity) async {
    return firebaseRemoteDataSource.signUp(userEntity);
  }

  @override
  Future<void> updateNote(NoteEntity noteEntity) async {
    return firebaseRemoteDataSource.updateNote(noteEntity);
  }

  Future<bool> isSignedIn() async {
    return firebaseRemoteDataSource.isSignedIn();
  }

  @override
  Future<void> signOut() async {
    return firebaseRemoteDataSource.signOut();
  }

  @override
  Future<String> getCurrentUid() async {
    return firebaseRemoteDataSource.getCurrentUid();
  }
}

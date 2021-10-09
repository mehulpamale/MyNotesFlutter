import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes_app/feature/data/remote/data_sources/firebase_remote_data_source.dart';
import 'package:notes_app/feature/data/remote/models/note_model.dart';
import 'package:notes_app/feature/data/remote/models/user_model.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';
import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future addNewNote(NoteEntity noteEntity) async {
    final noteCollectionRf =
        firestore.collection('users').doc(noteEntity.uid).collection('notes');
    final noteId = noteCollectionRf.doc().id;
    noteCollectionRf.doc(noteId).get().then((note) {
      print(note);
      final newNote = NoteModel(
              uid: noteEntity.uid,
              noteId: noteId,
              note: noteEntity.note,
              timeStamp: noteEntity.timeStamp)
          .toDocument();
      print('newNote: ${newNote}');
      print('noteId: ${noteId}');
      // if (noteId == null) {
      if (!note.exists) {
        noteCollectionRf.doc(noteId).set(newNote);
      }
      return;
    });
  }

  @override
  Future deleteNewNote(NoteEntity noteEntity) async {
    print('in remote ds impl delete note ');
    final noteCollectionRf =
        firestore.collection('users').doc(noteEntity.uid).collection('notes');
    noteCollectionRf.doc(noteEntity.noteId).get().then((value) {
      if (value.exists) {
        noteCollectionRf.doc(noteEntity.noteId).delete();
      }
    });
  }

  // CollectionReference getNoteCollectionRf(NoteEntity noteEntity) =>
  //     getNoteCollectionRf;

  @override
  Future getCreateCurrentUser(UserEntity userEntity) async {
    final userCollRef = firestore.collection('users');
    final uid = await getCurrentUid();
    userCollRef.doc(uid).get().then((value) {
      final newUser = UserModel(
              uid: uid,
              status: userEntity.status,
              email: userEntity.email,
              name: userEntity.name)
          .toDocument();
      if (!value.exists) {
        userCollRef.doc(uid).set(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUid() async {
    return auth.currentUser!.uid;
  }

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollRef =
        firestore.collection('users').doc(uid).collection('notes');
    return noteCollRef.snapshots().map((querySnap) {
      print('querySnap: ${querySnap.docs}');
      return querySnap.docs.map((documentSnap) {
        print('e.data(): ${documentSnap.data()}');
        return NoteModel.fromSnapshot(documentSnap);
      }).toList();
    });
  }

  @override
  Future<bool> isSignedIn() async => auth.currentUser?.uid != null;

  @override
  Future signIn(UserEntity userEntity) => auth.signInWithEmailAndPassword(
      email: userEntity.email!, password: userEntity.password!);

  @override
  Future signOut() {
    return auth.signOut();
  }

  @override
  Future signUp(UserEntity userEntity) {
    return auth.createUserWithEmailAndPassword(
        email: userEntity.email!, password: userEntity.password!);
  }

  @override
  Future updateNote(NoteEntity noteEntity) {
    final noteMap = <String, dynamic>{};
    final noteCollRef =
        firestore.collection('users').doc(noteEntity.uid).collection('notes');
    if (noteEntity.note != null) noteMap['note'] = noteEntity.note;
    if (noteEntity.timeStamp != null)
      noteMap['timeStamp'] = noteEntity.timeStamp;
    return noteCollRef.doc(noteEntity.noteId).update(noteMap);
  }
}

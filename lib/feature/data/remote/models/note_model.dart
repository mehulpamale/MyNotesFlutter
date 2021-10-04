import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/entities/user_entity.dart';

class NoteModel extends NoteEntity {
  String? noteId;
  String? note;
  Timestamp? timeStamp;
  String? uid;

  NoteModel({
    this.noteId,
    this.note,
    this.timeStamp,
    this.uid,
  }) : super(
          noteId: noteId,
          note: note,
          timeStamp: timeStamp,
          uid: uid,
        );

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NoteModel(
      noteId: documentSnapshot['noteId'],
      note: documentSnapshot['note'],
      timeStamp: documentSnapshot['timeStamp'],
      uid: documentSnapshot['uid'],
    );
  }

  Map<String, dynamic> toDocument() {
    final noteMap = <String, dynamic>{
      'noteId': noteId,
      'note': note,
      'timeStamp': timeStamp,
      'uid': uid,
    };
    print('noteMap: ${noteMap}');
    return noteMap;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/presentation/cubit/notelist/note_cubit.dart';

class UpdateNotePage extends StatefulWidget {
  NoteEntity noteEntity;

  UpdateNotePage({Key? key, required this.noteEntity}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<UpdateNotePage> {
  final _noteController = TextEditingController();

  final _key = GlobalKey<ScaffoldState>();
  late NoteCubit noteCubit;

  @override
  void initState() {
    // TODO: implement initState
    noteCubit = BlocProvider.of<NoteCubit>(context);
    _noteController.text = widget.noteEntity.note ?? 'empty';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('note'),
      ),
      body: Column(
        children: [
          Scrollbar(
            child: TextFormField(
              controller: _noteController,
              minLines: 6,
              maxLines: 6,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'enter your note'),
            ),
          ),
          ElevatedButton(onPressed: _addNewNote, child: Text('update note'))
        ],
      ),
    );
  }

  void _addNewNote() {
    if (_noteController.text.isEmpty) {
      print('empty text');
      snackBarError('type something', _key);
      return;
    }
    BlocProvider.of<NoteCubit>(context).updateNote(NoteEntity(
      note: _noteController.text,
      noteId: widget.noteEntity.noteId,
      timeStamp: Timestamp.now(),
      uid: widget.noteEntity.uid,
    ));
    Navigator.pop(context);
  }
}

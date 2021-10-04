import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/presentation/cubit/notelist/note_cubit.dart';

class AddNewNotePage extends StatefulWidget {
  String uid;

  AddNewNotePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final _noteController = TextEditingController();

  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _noteController.addListener(() {
      setState(() {
        print(_noteController.text);
      });
    });
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
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'enter your note'),
            ),
          ),
          ElevatedButton(onPressed: _addNewNote, child: Text('add'))
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
    BlocProvider.of<NoteCubit>(context).addNote(NoteEntity(
        note: _noteController.text,
        timeStamp: Timestamp.now(),
        uid: widget.uid));
    Navigator.pop(context);
  }
}

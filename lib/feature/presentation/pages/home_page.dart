import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/app_constants.dart';
import 'package:notes_app/feature/data/remote/models/note_model.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/presentation/cubit/notelist/note_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (c, noteState) {
          if (noteState is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (noteState is NoteLoaded) {
            return _bodyWidget(noteState);
          } else if (noteState is NoteFailure) {
            return Center(child: Text('note failure:${noteState.failure}'));
          }
          return Center(child: Text('Failure'));
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, PageConst.addNotePage,
                arguments: widget.uid);
          }),
    );
  }

  Widget _bodyWidget(NoteLoaded noteLoaded) {
    return noteLoaded.notes.isEmpty
        ? _noNotesWidget()
        : GridView.builder(
            itemCount: noteLoaded.notes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.2),
            itemBuilder: (_, i) {
              NoteEntity? noteEntity = noteLoaded.notes[i];
              return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, PageConst.updateNotePage,
                      arguments: noteEntity),
                  onLongPress: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Delete Note?'),
                            content: Text('Are you sure to delete?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    BlocProvider.of<NoteCubit>(context)
                                        .deleteNote(noteEntity!);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Yes')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('No'))
                            ],
                          )),
                  child: Card(
                    child: noteEntity == null
                        ? Text('null')
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(children: [
                              Text(
                                noteEntity.note!,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(DateFormat('dd/MM/yyyy hh:mm:a')
                                  .format(noteEntity.timeStamp!.toDate()))
                            ])),
                  ));
            },
          );
  }

  Widget _noNotesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(Icons.error_outline), Text('no notes')],
      ),
    );
  }
}

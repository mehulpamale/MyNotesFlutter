import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';
import 'package:notes_app/feature/domain/use_cases/add_new_note_uc.dart';
import 'package:notes_app/feature/domain/use_cases/delete_note_uc.dart';
import 'package:notes_app/feature/domain/use_cases/get_notes_uc.dart';
import 'package:notes_app/feature/domain/use_cases/update_note_uc.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final AddNewNoteUseCase addNewNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNotesUseCase getNotesUseCase;

  NoteCubit(this.updateNoteUseCase, this.deleteNoteUseCase,
      this.getNotesUseCase, this.addNewNoteUseCase)
      : super(NoteInitial());

  Future<void> addNote(NoteEntity noteEntity) async {
    try {
      await addNewNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> getNotes(String uid) async {
    emit(NoteLoading());
    try {
      await getNotesUseCase.call(uid).listen((notes) {
        emit(NoteLoaded(notes));
      });
    } catch (e) {
      emit(NoteFailure(failure: e.toString()));
    }
  }

  Future<void> deleteNote(NoteEntity noteEntity) async {
    print('in delete note cubit');
    try {
      await deleteNoteUseCase.call(noteEntity);
    } on Exception catch (e) {
      emit(NoteFailure(failure: e.toString()));
    }
  }

  Future<void> updateNote(NoteEntity noteEntity) async {
    try {
      await updateNoteUseCase.call(noteEntity);
    } catch (e) {
      NoteFailure(failure: e.toString());
    }
  }
}

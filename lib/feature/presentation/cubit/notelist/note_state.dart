part of 'note_cubit.dart';

@immutable
abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteFailure extends NoteState {
  String? failure;

  NoteFailure({this.failure});
}

class NoteLoaded extends NoteState {
  List<NoteEntity?> notes;

  NoteLoaded(this.notes);
}

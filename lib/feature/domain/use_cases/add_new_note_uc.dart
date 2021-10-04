import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class AddNewNoteUseCase {
  final FirebaseRepository firebaseRepository;

  AddNewNoteUseCase(this.firebaseRepository);

  Future<void> call(NoteEntity noteEntity) async {
    return firebaseRepository.addNewNote(noteEntity);
  }
}

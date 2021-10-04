import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class DeleteNoteUseCase {
  final FirebaseRepository firebaseRepository;

  DeleteNoteUseCase(this.firebaseRepository);

  Future<void> call(NoteEntity noteEntity) async {
    return firebaseRepository.deleteNewNote(noteEntity);
  }
}

import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class UpdateNoteUseCase {
  final FirebaseRepository firebaseRepository;

  UpdateNoteUseCase(this.firebaseRepository);

  Future<void> call(NoteEntity noteEntity) async {
    return firebaseRepository.updateNote(noteEntity);
  }
}

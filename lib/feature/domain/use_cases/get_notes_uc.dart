import 'package:notes_app/feature/domain/repositories/firebase_repository.dart';
import 'package:notes_app/feature/domain/entities/note_entity.dart';

class GetNotesUseCase {
  final FirebaseRepository firebaseRepository;

  GetNotesUseCase(this.firebaseRepository);

  Stream<List<NoteEntity?>> call(String uid) {
    return firebaseRepository.getNotes(uid);
  }
}
